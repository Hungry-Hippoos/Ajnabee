from rest_framework import serializers
from ajnabee.rtest.models import RtestModel

class RtestSerializer(serializers.ModelSerializer):
    class Meta:
        model = RtestModel
        fields = ["username"]