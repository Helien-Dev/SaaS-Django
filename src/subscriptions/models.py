from django.db import models
from django.contrib.auth.models import Group, Permission
from django.db.models.signals import post_save
from django.conf import settings

User = settings.AUTH_USER_MODEL
SUBCRIPTION_PERMISSION = [
    ("basic", "Basic Perm"),
    ("pro", "Pro Perm"),
    ("advanced", "Advanced Perm"),
]

# Create your models here.
class Subscriptions(models.Model):
    name = models.CharField(max_length=120)
    active = models.BooleanField(default=True)
    groups = models.ManyToManyField(Group)
    permissions = models.ManyToManyField(Permission, limit_choices_to={
        "content_type__app_label": "subscriptions",
        "codename_in": [x[0] for x in SUBCRIPTION_PERMISSION],
    })

    def __str__(self) -> str:
        return f"{self.name}"
    
    class Meta:
        permissions = SUBCRIPTION_PERMISSION

class UserSubscription(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    subscription = models.ForeignKey(
        Subscriptions,
        on_delete=models.SET_NULL,
        null=True,
        blank=True
    )
    active = models.BooleanField(default=True)

def user_sub_post_save(sender, instance, *args, **kwargs):
    user_sub_instance = instance
    user = user_sub_instance.user
    subscription_obj = user_sub_instance.subscription
    groups = subscription_obj.groups.all()
    user.groups.set(groups)
