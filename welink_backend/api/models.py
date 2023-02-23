from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.


class User(AbstractUser):
    pass


class LinkProfile(models.Model):
    profile_title = models.CharField(max_length=50)
    description = models.CharField(max_length=250, null=True, blank=True)
    views = models.IntegerField(null=True, blank=True, default=0)
    user = models.OneToOneField("User", on_delete=models.CASCADE)
    avatar = models.ImageField(null=True, blank=True)


class Link(models.Model):
    profile = models.ForeignKey("LinkProfile", on_delete=models.CASCADE)
    label = models.CharField(max_length=50)
    href = models.CharField(max_length=50)
    icon = models.ImageField()
    clicks = models.IntegerField(default=0)
