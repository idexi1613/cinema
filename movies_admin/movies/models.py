import uuid
from django.db import models
from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils.translation import gettext_lazy as _


class TimeStampedMixin(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    modified = models.DateTimeField(auto_now=True)

    class Meta:
        abstract=True


class UUIDMixin(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)

    class Meta:
        abstract=True


class Genre(TimeStampedMixin, UUIDMixin):
    def __str__(self):
        return self.name
    
    name = models.CharField(_('name'), max_length=255)
    description = models.TextField(_('description'), blank=True)

    class Meta:
        db_table = "content\".\"genre"
        verbose_name = 'Жанр'
        verbose_name_plural = 'Жанры'


class Filmwork(UUIDMixin, TimeStampedMixin):
    class FilmType(models.TextChoices):
        MOVIES = _('movies')
        TV_SHOW = _('tv_show')
                   
    def __str__(self):
        return self.title
    
    certificate = models.CharField(_('certificate'), max_length=512, blank=True)
    file_path = models.FileField(_('file'), blank=True, upload_to='movies/')
    title = models.CharField(_('title'), max_length=300)
    description = models.TextField(_('description'), blank=True)
    creation_date = models.DateField(_('creation_date'))
    rating = models.FloatField(_('rating'), blank=True,
                               validators=[MinValueValidator(0), MaxValueValidator(10)])
    type = models.CharField(_('type'), choices=FilmType.choices)

    class Meta:
        db_table = "content\".\"film_work"
        verbose_name = 'Кинопроизведение'
        verbose_name_plural = 'Кинопроизведения'


class GenreFilmwork(UUIDMixin):
    film_work = models.ForeignKey(Filmwork, on_delete=models.CASCADE)
    genre = models.ForeignKey(Genre, on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "content\".\"genre_film_work"
        verbose_name = 'Жанр кинопроизведения'
        verbose_name_plural = 'Жанры кинопроизведений'

class Person(TimeStampedMixin, UUIDMixin):
    def __str__(self):
        return self.full_name
    
    full_name = models.CharField(_('full_name'), max_length=200, blank=True)
        
    class Meta:
        db_table = "content\".\"person"
        verbose_name = 'Персона'
        verbose_name_plural = 'Персоны'


class PersonFilmwork(UUIDMixin):
    person_id = models.ForeignKey(Person, on_delete=models.CASCADE)
    film_work_id = models.ForeignKey(Filmwork, on_delete=models.CASCADE)
    role = models.CharField(max_length=100, blank=True, null=True)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "content\".\"person_film_work"
        verbose_name = 'Персоналия киинопроизведения'
        verbose_name_plural = 'Персоналии киинопроизведений'

