# Generated by Django 4.1.5 on 2023-02-25 08:27

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0007_alter_linkstyle_ishardshadow'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='linkstyle',
            name='shadows',
        ),
    ]
