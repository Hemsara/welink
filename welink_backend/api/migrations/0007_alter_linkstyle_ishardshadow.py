# Generated by Django 4.1.5 on 2023-02-25 08:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0006_linkstyle_linkprofile_color_hex_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='linkstyle',
            name='isHardShadow',
            field=models.BooleanField(default=False),
        ),
    ]
