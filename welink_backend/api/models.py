from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
class User(AbstractUser):
   image_url  = models.CharField( max_length=3550 , null=True)   