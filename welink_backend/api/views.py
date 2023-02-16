from django.shortcuts import render
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from .serializers import UserSerializer
from rest_framework import status


@api_view(['POST'])
@permission_classes((AllowAny, ))
def registerUser(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        Newuser = serializer.save()
        if Newuser:
            return Response(status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



