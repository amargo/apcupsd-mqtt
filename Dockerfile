FROM python:3.12.0a1-alpine
LABEL org.opencontainers.image.source="https://github.com/amargo/apcupsd-mqtt"

WORKDIR /app

# upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# install requirements
COPY src/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY src/apcupsd-mqtt.py ./
COPY src/config.yml ./

CMD ["python", "/app/apcupsd-mqtt.py"]
