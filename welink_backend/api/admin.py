from django.contrib import admin
from .models import User, Link, LinkProfile
# Register your models here.

admin.site.register(User)
admin.site.register(LinkProfile)
admin.site.register(Link)
