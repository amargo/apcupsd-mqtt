FROM python:3.14-alpine
LABEL org.opencontainers.image.source="https://github.com/amargo/apcupsd-mqtt"

WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Upgrade pip and install requirements
COPY src/requirements.txt ./
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY src/apcupsd-mqtt.py ./
COPY src/config.yml ./

CMD ["python", "/app/apcupsd-mqtt.py"]
