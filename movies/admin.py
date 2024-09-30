from django.contrib import admin
from .models import Genre, Filmwork, GenreFilmwork, Person,\
PersonFilmwork

# Register your models here.


@admin.register(Genre)
class GenreAdmin(admin.ModelAdmin):
    # Отображение полей в списке
    list_display = ('name', 'created', 'modified')

    # Фильтрация полей
    list_filter = ('name',)

    # Поиск
    search_fields = ('name', 'id')


class GenreFilmworkInline(admin.TabularInline):
    model = GenreFilmwork

@admin.register(Filmwork)
class FilmworkAdmin(admin.ModelAdmin):
    inlines = (GenreFilmworkInline,)

    # Отображение полей в списке
    list_display = ('title', 'type', 'creation_date', 'rating')

    # Фильтрация
    list_filter = ('type', 'creation_date')

    # Поиск
    search_fields = ('title', 'description', 'id')


class PersonFilmworkInline(admin.TabularInline):
    model = PersonFilmwork

@admin.register(Person)
class PersonAdmin(admin.ModelAdmin):
    inlines = (PersonFilmworkInline,)

    list_display = ('full_name', 'created', 'modified')

    list_filter = ('created', 'modified')

    search_fields = ('full_name', 'id')
