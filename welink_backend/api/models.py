from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.


class User(AbstractUser):
    pass


class LinkProfile(models.Model):
    profile_title = models.CharField(max_length=50)
    description = models.CharField(max_length=50)
    views = models.IntegerField()
    user = models.OneToOneField("User", on_delete=models.CASCADE)
    avatar = models.ImageField()


class Link(models.Model):
    profile = models.ForeignKey("LinkProfile", on_delete=models.CASCADE)
    label = models.CharField(max_length=50)
    href = models.CharField(max_length=50)
    icon = models.ImageField()
    clicks = models.IntegerField()
