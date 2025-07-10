import pathlib
from django.shortcuts import render
from django.http import HttpResponse

from visits.models import PageVisit

def home_view(request, *args, **kwargs):
    
    qs = PageVisit.objects.all()
    page_qs = PageVisit.objects.filter(path=request.path)
    
    context = {
        "page_title": "Home Page",
        "content": "Welcome to my SaaS application!",
        "page_visit_count": page_qs.count(),
        "percent": (page_qs.count() * 100.0)/ qs.count(),
        "total_visit_count": qs.count()
    }
    
    PageVisit.objects.create(path=request.path)
    
    return render(request, "home.html", context)
