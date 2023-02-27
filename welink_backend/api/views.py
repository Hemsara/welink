from django.shortcuts import render
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from .serializers import UserCreateSerializer, ProfileViewSerializer, LinkProfileSerializer, LinkStyleSerializer, ProfileUpdateSerializer, LinkSerializer
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


@api_view(['POST'])
@permission_classes((AllowAny, ))
def saveLink(request):
    serializer = LinkSerializer(data=request.data)
    if serializer.is_valid():
        Newuser = serializer.save()
        if Newuser:
            return Response(serializer.data, status=status.HTTP_201_CREATED)
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


@api_view(['GET'])
@permission_classes((AllowAny, ))
def getLinkFromUser(request, username):
    try:
        user = models.User.objects.get(username=username)
        profile = models.LinkProfile.objects.get(user=user)
        models.LinkProfile.objects.filter(
            user=user).update(views=profile.views + 1)
        serializer = ProfileViewSerializer(profile)
        return Response({"data": serializer.data})
    except models.User.DoesNotExist:
        return Response({"error": "user doesn't exist"}, status=status.HTTP_404_NOT_FOUND)
    except:
        return Response({"error": "something went wrong"}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
@permission_classes((IsAuthenticated, ))
def getStyles(request):
    styles = models.LinkStyle.objects.all()
    print(styles)
    serializer = LinkStyleSerializer(styles, many=True)
    return Response({"data": serializer.data})


@api_view(['PATCH'])
@permission_classes((IsAuthenticated, ))
def updateProfile(request):
    profile = models.LinkProfile.objects.get(user=request.user)
    serializer = ProfileUpdateSerializer(
        data=request.data, instance=profile, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response({"status": "updated"}, status=status.HTTP_201_CREATED)
    print(serializer.errors)
    return Response({"error": serializer.error_messages})


@api_view(['POST'])
@permission_classes((AllowAny, ))
def RecordClick(request, id):
    try:
        link = models.Link.objects.get(id=id)
        print(link)
        models.Link.objects.filter(id=id).update(clicks=link.clicks + 1)
        return Response({"status": "success"})

    except:
        return Response({"error": "something went wrong"}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['PATCH'])
@permission_classes((AllowAny, ))
def updateVisibility(request, id):
    try:
        link = models.Link.objects.get(id=id)
        print(link)
        models.Link.objects.filter(id=id).update(
            visible=not link.visible)
        return Response({"status": "success"})
    except models.Link.DoesNotExist:
        return Response({"error": "link doesn't exist"}, status=status.HTTP_404_NOT_FOUND)
    except:
        return Response({"error": "something went wrong"}, status=status.HTTP_400_BAD_REQUEST)
