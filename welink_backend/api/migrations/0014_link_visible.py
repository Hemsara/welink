# Generated by Django 4.1.5 on 2023-02-26 19:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0013_alter_link_href'),
    ]

    operations = [
        migrations.AddField(
            model_name='link',
            name='visible',
            field=models.BooleanField(default=True),
        ),
    ]
