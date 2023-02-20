from django.shortcuts import render
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from .serializers import UserCreateSerializer, LinkSerializer, LinkProfileSerializer
from rest_framework import status
from . import models


@api_view(['POST'])
@permission_classes((AllowAny, ))
def registerUser(request):
    serializer = UserCreateSerializer(data=request.data)
    if serializer.is_valid():
        Newuser = serializer.save()
        if Newuser:
            return Response(status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
@permission_classes((IsAuthenticated, ))
def checkAuthenticated(request):
    return Response({"authenticated": True})


@api_view(['GET'])
@permission_classes((IsAuthenticated, ))
def overview(request):

    profile = models.LinkProfile.objects.get(user=request.user)
    if profile:
        serializer = LinkProfileSerializer(profile)
        return Response({"data": serializer.data})
    profile = models.LinkProfile.objects.create(
        user=request.user, profile_title=request.user.username)
    serializer = LinkProfileSerializer(profile)
    return Response({"data": serializer.data})
