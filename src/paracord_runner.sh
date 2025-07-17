#!/bin/sh

# Esperar a que la base de datos esté lista (ajusta si usas base de datos)
echo "Esperando a que la base de datos esté lista..."
sleep 5

# Ejecutar migraciones
echo "Ejecutando migraciones..."
python manage.py migrate --noinput

# Crear superusuario si no existe (ajustable)
echo "Creando superusuario si no existe..."
echo "
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
" | python manage.py shell

# Recoger archivos estáticos
echo "Recolectando archivos estáticos..."
python manage.py collectstatic --noinput

# Iniciar el servidor Gunicorn
echo "Iniciando Gunicorn..."
gunicorn SaaS_Project.wsgi:application --bind 0.0.0.0:8000
