import os
import sqlite3
from typing import Generator, Type


BATCH_SIZE = 100

common_field_mapping = {
       'created_at': 'created',
       'updated_at': 'modified'
}
           
field_mappings = {
   'film_work': {**common_field_mapping},
   'genre': {**common_field_mapping},
   'genre_film_work': {'created_at': 'created'},
   'person': {**common_field_mapping},
   'person_film_work': {'created_at': 'created'},
}


def extract_data(sqlite_cursor: sqlite3.Cursor, table_name: str) -> Generator[list[sqlite3.Row], None, None]:
    sqlite_cursor.execute(f'SELECT * FROM {table_name}')
    while results := sqlite_cursor.fetchmany(BATCH_SIZE):
        yield results


def transform_data(sqlite_cursor: sqlite3.Cursor, dataclass_type: Type, table_name: str) -> Generator[list, None, None]:
    # Получаем маппинг для текущей таблицы
    field_mapping = field_mappings.get(table_name, {})

    # Извлекаем данные из SQLite
    for batch in extract_data(sqlite_cursor, table_name):
        transformed_batch = []
        for row in batch:
            # Преобразуем строку в словарь
            row_dict = dict(row)

            # Применяем маппинг полей
            mapped_row = {field_mapping.get(k, k): v for k, v in row_dict.items()}

            print(f'вывод {mapped_row}')
            # Создаем объект dataclass
            transformed_batch.append(dataclass_type(**mapped_row))
        
        yield transformed_batch 
 