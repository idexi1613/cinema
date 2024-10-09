from django.db import models
from .mixins import TimeStampedMixin, UUIDMixin
from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils.translation import gettext_lazy as _


class Genre(TimeStampedMixin, UUIDMixin):
    
    name = models.CharField(_('name'), max_length=255)
    description = models.TextField(_('description'), blank=True, null=True)

    class Meta:
        db_table = "content\".\"genre"
        verbose_name = 'Жанр'
        verbose_name_plural = 'Жанры'

        indexes = [
            models.Index(fields=['name'])
        ]
    
    def __str__(self):
        return self.name

class Filmwork(UUIDMixin, TimeStampedMixin):
    class FilmType(models.TextChoices):
        MOVIES = _('movie')
        TV_SHOW = _('tv_show')
    
    certificate = models.CharField(_('certificate'), max_length=512, blank=True, null=True) 
    file_path = models.FileField(_('file'), blank=True, upload_to='movies/', null=True)
    title = models.CharField(_('title'), max_length=300)
    description = models.TextField(_('description'), blank=True, null=True)
    creation_date = models.DateField(_('creation_date'), blank=True, null=True)
    rating = models.FloatField(_('rating'), blank=True, null=True,
                               validators=[MinValueValidator(0), MaxValueValidator(10)])
    type = models.CharField(_('type'), choices=FilmType.choices)

    class Meta:
        db_table = "content\".\"film_work"
        verbose_name = 'Кинопроизведение'
        verbose_name_plural = 'Кинопроизведения'

        indexes = [
            models.Index(fields=['title']),
            models.Index(fields=['creation_date'])
        ]


    def __str__(self):
        return self.title

class GenreFilmwork(UUIDMixin):
    film_work = models.ForeignKey(Filmwork, on_delete=models.CASCADE)
    genre = models.ForeignKey(Genre, on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "content\".\"genre_film_work"
        verbose_name = 'Жанр кинопроизведения'
        verbose_name_plural = 'Жанры кинопроизведений'

        indexes = [
            models.Index(fields=['film_work_id', 'genre_id'], name='genre_film_work_idx')
        ]        

class Person(TimeStampedMixin, UUIDMixin):
    full_name = models.CharField(_('full_name'), max_length=200, blank=True, null=True)
        
    class Meta:
        db_table = "content\".\"person"
        verbose_name = 'Персона'
        verbose_name_plural = 'Персоны'

        indexes = [
            models.Index(fields=['full_name'])
        ]

    def __str__(self):
        return self.full_name


class PersonFilmwork(UUIDMixin):
    person = models.ForeignKey(Person, on_delete=models.CASCADE)
    film_work = models.ForeignKey(Filmwork, on_delete=models.CASCADE)
    role = models.CharField(max_length=100, blank=True, null=True)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "content\".\"person_film_work"
        verbose_name = 'Персоналия киинопроизведения'
        verbose_name_plural = 'Персоналии киинопроизведений'

        indexes = [
            models.Index(fields=['film_work_id', 'person_id'], name='person_film_work_idx')
        ]
        

