
from rest_framework import serializers
from .models import User, Link, LinkProfile, LinkStyle


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


class LinkStyleSerializer(serializers.ModelSerializer):
    class Meta:
        model = LinkStyle
        fields = "__all__"


class LinkViewOnlySerializer(serializers.ModelSerializer):
    class Meta:
        model = Link
        fields = ('id', 'label', 'href', 'icon')
        depth = 2


class LinkProfileSerializer(serializers.ModelSerializer):
    links = serializers.SerializerMethodField()
    user = UserSerializer()
    clicks = serializers.SerializerMethodField()
    style = LinkStyleSerializer()

    class Meta:
        depth: 2
        model = LinkProfile
        fields = "__all__"

    def get_clicks(self, obj):
        clicks = 0
        links = Link.objects.filter(profile=obj)
        for x in links:
            clicks += x.clicks
        return clicks

    def get_links(self, obj):
        links = Link.objects.filter(profile=obj)
        print(links)
        data = LinkSerializer(links, many=True).data
        return data

    def update(self, instance, validated_data):
        print("wohoooo")
        return instance


class ProfileViewSerializer(serializers.ModelSerializer):
    links = serializers.SerializerMethodField()
    style = LinkStyleSerializer(read_only=True)

    class Meta:
        model = LinkProfile
        fields = ('id', 'links', 'profile_title',
                  'description', 'avatar', 'style', 'radius', 'gradient_up', 'color_hex')

    def get_links(self, obj):
        links = Link.objects.filter(profile=obj)
        data = LinkViewOnlySerializer(links, many=True).data
        return data


class ProfileUpdateSerializer(serializers.ModelSerializer):

    class Meta:
        model = LinkProfile
        fields = "__all__"
