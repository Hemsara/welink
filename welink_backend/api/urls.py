from django.urls import path
from .views import registerUser, checkAuthenticated
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('register/', registerUser),
    path('login/', obtain_auth_token),
    path('auth', checkAuthenticated),


]
