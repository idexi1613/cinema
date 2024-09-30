import os
import sqlite3
import psycopg
from psycopg.rows import dict_row
from dataclasses import astuple
from contextlib import closing
from sqlite_utils import transform_data
from postgres_utils import load_data, test_transfer
from datetime import datetime
from data_config import dsl
from data_config import tables


db_path = os.getenv('DB_PATH')

if __name__ == '__main__':
    with closing(sqlite3.connect(db_path)) as sqlite_conn, closing(psycopg.connect(**dsl)) as pg_conn:
        sqlite_conn.row_factory = sqlite3.Row
        with closing(sqlite_conn.cursor()) as sqlite_cur, closing(pg_conn.cursor(row_factory=dict_row)) as pg_cur:

            # Функция для обработки данных перед вставкой
            def replace_empty_and_convert_to_date(record):
                """Заменяет пустые строки на None и преобразует datetime в date"""
                processed_record = []
                for value in record:
                    if value == '':
                        processed_record.append(None)  # Заменяем пустую строку на None
                    elif isinstance(value, datetime):
                        # Преобразуем datetime в date
                        processed_record.append(value.date())
                    else:
                        processed_record.append(value)
                return tuple(processed_record)

            # Перенос данных для каждой таблицы
            for table_name, dataclass_type in tables.items():
                print(f"Перенос данных из таблицы {table_name}")

                # Получаем список колонок из dataclass
                columns = [field for field in dataclass_type.__annotations__.keys()]

                # Извлечение и загрузка данных
                for batch in transform_data(sqlite_cur, dataclass_type, table_name):
                    batch_as_tuples = [astuple(record) for record in batch]
                    
                    # Обработка данных для каждой записи в batch
                    batch_as_tuples = [replace_empty_and_convert_to_date(record) for record in batch_as_tuples]

                    # Логирование данных для проверки перед вставкой
                    for record in batch_as_tuples:
                        print(f'Значение для вставки: {record}')

                    # Вставка данных в PostgreSQL
                    load_data(pg_cur, table_name, batch_as_tuples, columns)

                # Фиксация изменений в PostgreSQL
                pg_conn.commit()

                # Тестирование корректности переноса данных
                test_transfer(sqlite_cur, pg_cur, table_name)

    print('🎉 Все данные успешно перенесены !!!')
