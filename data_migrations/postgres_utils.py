import sqlite3
import psycopg
from typing import List, Type
from sqlite_utils import field_mappings, BATCH_SIZE
# from data_config import tables
from data_classes import Filmwork, Genre, GenreFilmWork, Person, PersonFilmWork
# print(tables)

tables = {
    'film_work': Filmwork,
    'genre': Genre,
    'genre_film_work': GenreFilmWork,
    'person': Person,
    'person_film_work': PersonFilmWork,
}


def get_postgres_connection(dsl: dict) -> psycopg.Connection:
    """Создание и возвращение подключения к базе данных PostgreSQL."""
    return psycopg.connect(**dsl)


def load_data(pg_cursor: psycopg.Cursor, table_name: str, data: List[tuple], columns: List[str]):
    """Загрузка данных в таблицу PostgreSQL с использованием dataclass."""
    # Получаем класс dataclass для данной таблицы
    if not data:
        return 
    
    values_placeholder = ', '.join(['%s'] * len(columns))
    
    # Формируем запрос для вставки данных
    query = f'INSERT INTO content.{table_name} ({", ".join(columns)}) VALUES ({values_placeholder}) ON CONFLICT (id) DO NOTHING'
    pg_cursor.executemany(query, data)

def test_transfer(sqlite_cursor: sqlite3.Cursor, pg_cursor: psycopg.Cursor, table_name: str):
    print(f"Ищем dataclass для таблицы {table_name}")
    
    # Получаем dataclass по имени таблицы
    dataclass_type = tables.get(table_name)
    if not dataclass_type:
        raise ValueError(f"Не найден класс dataclass для таблицы {table_name}")

    # Получаем маппинг полей для данной таблицы
    field_mapping = field_mappings.get(table_name, {})

    # Извлекаем данные из SQLite
    sqlite_cursor.execute(f'SELECT * FROM {table_name}')
    while batch := sqlite_cursor.fetchmany(BATCH_SIZE):
        original_batch = []
        for row in batch:
            # Преобразуем строку в словарь
            row_dict = dict(row)

            # Применяем маппинг для переименования полей
            mapped_row = {field_mapping.get(k, k): v for k, v in row_dict.items()}

            # Создание объекта dataclass с применённым маппингом
            original_batch.append(dataclass_type(**mapped_row))

        ids = [row.id for row in original_batch]

        # Извлекаем данные из PostgreSQL
        pg_cursor.execute(f'SELECT * FROM content.{table_name} WHERE id = ANY(%s)', [ids])
        transferred_batch = []
        for row in pg_cursor.fetchall():
            
            # Применяем маппинг для данных из PostgreSQL
            row_dict = dict(row)
            mapped_row = {field_mapping.get(k, k): v for k, v in row_dict.items()}
            transferred_batch.append(dataclass_type(**mapped_row))

        # Сравниваем данные
            
        if len(original_batch) != len(transferred_batch):
            print(f'Кол-во не совпадает. Sqlite: {original_batch}, postgres: {transferred_batch}')

        if original_batch != transferred_batch:
            print(f"Несовпадающие записи. Оригинал: {original_batch}\nПеренесено: {transferred_batch}")
