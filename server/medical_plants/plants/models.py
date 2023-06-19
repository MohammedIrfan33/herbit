from django.db import models

# Create your models here.

class testing(models.Model):
    answer = models.CharField(max_length=50)
    image_status = models.CharField(max_length=10)