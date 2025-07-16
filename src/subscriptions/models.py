from django.db import models

# Create your models here.
class Subscriptions(models.Model):
    name = models.CharField(max_length=120)

    class Meta:
        permissions = [
            ("basic", "Basic Perm"),
            ("pro", "Pro Perm"),
            ("advanced", "Advanced Perm"),
        ]
    