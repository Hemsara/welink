
from rest_framework import serializers
from .models import User, Link, LinkProfile


class UserCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('username', 'password', 'email')

    def create(self, validated_data):
        password = validated_data.pop('password', None)
        instance = self.Meta.model(**validated_data)
        if password is not None:
            instance.set_password(password)

        instance.save()
        return instance


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'first_name', 'last_name', 'email')


class LinkSerializer(serializers.ModelSerializer):
    class Meta:
        model = Link
        fields = "__all__"


class LinkProfileSerializer(serializers.ModelSerializer):
    links = serializers.SerializerMethodField()
    user = UserSerializer()

    class Meta:
        model = LinkProfile
        fields = "__all__"

    def get_links(self, obj):
        links = Link.objects.filter(profile=obj)
        print(links)
        data = LinkSerializer(links, many=True).data
        return data
