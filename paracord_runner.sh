#!/bin/bash

# Establece un puerto por defecto si no se proporciona
RUN_PORT="${PORT:-8000}"

echo "🔧 Esperando a que la base de datos esté disponible..."

# Aquí puedes agregar una espera opcional si la DB no está lista inmediatamente.
# Ejemplo con sleep o un script tipo wait-for-it si usas base de datos externa.
# sleep 5

echo "✅ Ejecutando vendor_pull..."
python manage.py vendor_pull

echo "✅ Ejecutando collectstatic..."
python manage.py collectstatic --noinput

echo "✅ Ejecutando migraciones..."
python manage.py migrate --noinput

echo "🚀 Iniciando Gunicorn en el puerto $RUN_PORT..."
gunicorn SaaS_Project.wsgi:application --bind "0.0.0.0:$RUN_PORT"
