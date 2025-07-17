ARG PYTHON_VERSION=3.13.5-slim-bullseye
FROM python:${PYTHON_VERSION}

RUN python -m venv /opt/venv
ENV PATH=/opt/venv/bin:$PATH

RUN pip install --upgrade pip

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libdbus-1-dev \
    libglib2.0-dev \
    pkg-config \
    cmake \
    meson \
    libpq-dev \
    libcairo2 \
    libjpeg-dev \
    gcc \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

ARG DJANGO_SECRET_KEY
ENV DJANGO_SECRET_KEY=${DJANGO_SECRET_KEY}

ARG DJANGO_DEBUG=0
ENV DJANGO_DEBUG=${DJANGO_DEBUG}

ARG PROJ_NAME="SaaS_Project"
ENV PROJ_NAME=${PROJ_NAME}

WORKDIR /code
COPY ./src /code

RUN chmod +x /code/paracord_runner.sh

CMD ["./paracord_runner.sh"]