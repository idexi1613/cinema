# Generated by Django 4.2.11 on 2024-09-20 17:31

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('movies', '0002_change_fields_import_content'),
    ] 

    operations = [
        migrations.RenameField(
            model_name='genrefilmwork',
            old_name='film_work_id',
            new_name='film_work',
        ),
        migrations.RenameField(
            model_name='genrefilmwork',
            old_name='genre_id',
            new_name='genre',
        ),
    ]
