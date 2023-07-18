from rest_framework import serializers
from django.conf import settings
from .models import testing


class PlantDetectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = testing
        fields = '__all__'
    def Create(self, validated_data):
        return testing.objects.Create(**validated_data)