# Generated by Django 4.1.5 on 2023-02-25 08:21

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_alter_linkprofile_avatar_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='LinkStyle',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('isFilled', models.BooleanField()),
                ('shadows', models.IntegerField()),
                ('isHardShadow', models.IntegerField()),
            ],
        ),
        migrations.AddField(
            model_name='linkprofile',
            name='color_hex',
            field=models.CharField(max_length=6, null=True),
        ),
        migrations.AddField(
            model_name='linkprofile',
            name='flat_color',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='linkprofile',
            name='gradient_up',
            field=models.BooleanField(default=True),
        ),
        migrations.AlterField(
            model_name='link',
            name='clicks',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='linkprofile',
            name='views',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
        migrations.AddField(
            model_name='linkprofile',
            name='style',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.linkstyle'),
        ),
    ]
