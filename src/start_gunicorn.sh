#!/bin/bash

exec uv run gunicorn SaaS_Project.wsgi:application \
  --bind 0.0.0.0:8000 \
  # --workers 3 \
  # --timeout 60 \
  # --access-logfile - \
  # --error-logfile -
