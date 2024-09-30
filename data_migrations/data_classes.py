from datetime import datetime, date
from uuid import UUID
from dataclasses import dataclass
from typing import Optional


@dataclass
class Filmwork:
    id: UUID
    title: str
    created: datetime
    description: Optional[str] = None
    modified: Optional[datetime] = None
    rating: Optional[float] = None
    type: Optional[str] = None
    certificate: Optional[str] = None
    file_path: Optional[str] = None
    creation_date: Optional[date] = None

    def __post_init__(self):
        if isinstance(self.id, str):
            self.id = UUID(self.id)

    # Преобразование строки в дату
        if isinstance(self.creation_date, str) and self.creation_date == '':
            self.creation_date = None
        elif isinstance(self.creation_date, str):
            try:
            # Преобразуем строку в объект date, если формат корректен
                self.creation_date = datetime.fromisoformat(self.creation_date).date()
            except ValueError:
                self.creation_date = None    

@dataclass
class Genre:
    id: UUID
    name: str
    description: str
    created: datetime
    modified: datetime

    def __post_init__(self):
        if isinstance(self.id, str):
            self.id = UUID(self.id)

@dataclass
class GenreFilmWork:
    id: UUID
    created: datetime
    film_work_id: UUID
    genre_id: UUID

    def __post_init__(self):
        if isinstance(self.id, str):
            self.id = UUID(self.id)

        if isinstance(self.film_work_id, str):
            self.film_work_id = UUID(self.film_work_id)

        if isinstance(self.genre_id, str):
            self.genre_id = UUID(self.genre_id)


@dataclass
class Person:
    id: UUID
    full_name: str
    created: datetime
    modified: datetime

    def __post_init__(self):
        if isinstance(self.id, str):
            self.id = UUID(self.id)


@dataclass
class PersonFilmWork:
    id: UUID
    role: str
    created: datetime
    film_work_id: UUID
    person_id: UUID

    def __post_init__(self):
        if isinstance(self.id, str):
            self.id = UUID(self.id)

        if isinstance(self.film_work_id, str):
            self.film_work_id = UUID(self.film_work_id)

        if isinstance(self.person_id, str):
            self.person_id = UUID(self.person_id)







    

