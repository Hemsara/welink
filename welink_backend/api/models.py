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
    # decoration
    color_hex = models.CharField(max_length=10, null=True)
    radius = models.IntegerField(null=True, default=0)
    gradient_up = models.BooleanField(default=True)
    flat_color = models.BooleanField(default=False)
    style = models.ForeignKey("LinkStyle", on_delete=models.CASCADE, null=True)


class Link(models.Model):
    profile = models.ForeignKey("LinkProfile", on_delete=models.CASCADE)
    label = models.CharField(max_length=50)
    href = models.CharField(max_length=2550)
    icon = models.CharField(max_length=2550)
    clicks = models.IntegerField(default=0)


class LinkStyle(models.Model):
    name = models.CharField(max_length=50)
    isFilled = models.BooleanField()
    isHardShadow = models.BooleanField(default=False)
    isSoftShadow = models.BooleanField(default=False)
