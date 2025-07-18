#!/bin/bash

# Establece un puerto por defecto si no se proporciona
RUN_PORT="${PORT:-8000}"

echo "🔧 Esperando a que la base de datos esté disponible..."

echo "✅ Ejecutando vendor_pull..."
python manage.py vendor_pull || {
    echo "⚠️ vendor_pull falló, continuando..."
}

echo "✅ Ejecutando collectstatic..."
python manage.py collectstatic --noinput || {
    echo "⚠️ collectstatic falló, continuando..."
}

echo "✅ Ejecutando migraciones..."
python manage.py migrate --noinput || {
    echo "⚠️ migrate falló, continuando..."
}

echo "🚀 Iniciando Gunicorn en el puerto $RUN_PORT..."
gunicorn SaaS_Project.wsgi:application --bind "0.0.0.0:$RUN_PORT" --workers 1 --timeout 120