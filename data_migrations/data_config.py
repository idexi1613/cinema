import os
from dotenv import load_dotenv
from data_classes import Filmwork, Genre, GenreFilmWork, Person, PersonFilmWork


load_dotenv()


tables = {
    'film_work': Filmwork,
    'genre': Genre,
    'genre_film_work': GenreFilmWork,
    'person': Person,
    'person_film_work': PersonFilmWork,
}
