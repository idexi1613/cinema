# Generated by Django 4.2.11 on 2024-10-08 19:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('movies', '0005_change_null'),
    ]

    operations = [
        migrations.AddIndex(
            model_name='filmwork',
            index=models.Index(fields=['title'], name='film_work_title_3625e7_idx'),
        ),
        migrations.AddIndex(
            model_name='filmwork',
            index=models.Index(fields=['creation_date'], name='film_work_creatio_02a6ad_idx'),
        ),
        migrations.AddIndex(
            model_name='genre',
            index=models.Index(fields=['name'], name='genre_name_bff4c4_idx'),
        ),
        migrations.AddIndex(
            model_name='genrefilmwork',
            index=models.Index(fields=['film_work_id', 'genre_id'], name='genre_film_work_idx'),
        ),
        migrations.AddIndex(
            model_name='person',
            index=models.Index(fields=['full_name'], name='person_full_na_058eac_idx'),
        ),
        migrations.AddIndex(
            model_name='personfilmwork',
            index=models.Index(fields=['film_work_id', 'person_id'], name='person_film_work_idx'),
        ),
    ]
