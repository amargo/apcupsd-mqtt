# APCUPSD to MQTT
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/86679e08d1544d5288653e1ce80486b2)](https://www.codacy.com/gh/amargo/apcupsd-mqtt/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=amargo/apcupsd-mqtt&amp;utm_campaign=Badge_Grade)

## Overview

This project provides a bridge between APC UPS devices (monitored by APCUPSD) and MQTT, with automatic integration into Home Assistant. It allows you to monitor your UPS status, battery levels, and other metrics directly in your Home Assistant dashboard.

### Features

- Publishes APCUPSD data to MQTT
- Home Assistant auto-discovery support (compatible with version 2021.11+)
- Stable device identification (prevents duplicate devices in Home Assistant)
- Configurable update intervals
- Comprehensive sensor data including battery status, voltage, load, and more

## Installation

### Docker

The recommended way to run this application is using Docker:

```bash
docker run -d \
    --restart always \
    --name 'apcupsd-mqtt' \
    -e UPS_ALIAS='ups_name' \
    ghcr.io/amargo/apcupsd-mqtt
```

### Docker Compose

Create a `docker-compose.yml` file:

```yaml
version: '3'

services:
  apcupsd-mqtt:
    image: ghcr.io/amargo/apcupsd-mqtt:latest
    container_name: apcupsd-mqtt
    restart: always
    environment:
      - UPS_ALIAS=ups_name
      - MQTT_HOST=mqtt.home
      # Add other environment variables as needed
```

Then run:

```bash
docker-compose up -d
```

## Configuration

### Environment Variables

| Variable | Description | Type | Default |
|----------|-------------|------|--------|
| `DEBUG` | Print all queried values on STDOUT | integer | `0` |
| `APCUPSD_HOST` | Hostname or IP address of the APCUPSD service | string | `127.0.0.1` |
| `UPS_ALIAS` | Device name (important for stable device identification) | string | *device serial or generated ID* |
| `APCUPSD_INTERVAL` | Refresh interval in seconds | integer | `10` |
| `MQTT_HOST` | MQTT broker hostname | string | `localhost` |
| `MQTT_PORT` | MQTT broker port | integer | `1883` |
| `MQTT_USER` | MQTT authentication username | string (optional) | - |
| `MQTT_PASSWORD` | MQTT authentication password | string (optional) | - |
| `USE_DEBUGPY` | Enable remote debugging with debugpy | integer | `0` |
| `DEBUGPY_PORT` | Port for debugpy | integer | `5678` |

### Usage Examples

#### Local APCUPSD + Local MQTT Broker

```bash
docker run -d \
    --restart always \
    --name 'apcupsd-mqtt' \
    -e UPS_ALIAS='garage' \
    ghcr.io/amargo/apcupsd-mqtt
```

#### Local APCUPSD + Remote MQTT Broker with Debug Logs

```bash
docker run -d \
    --restart always \
    --name 'apcupsd-mqtt' \
    -e UPS_ALIAS='garage' \
    -e MQTT_HOST='mqtt.home' \
    -e DEBUG=1 \
    ghcr.io/amargo/apcupsd-mqtt
```

#### Remote APCUPSD + Authentication Required MQTT Broker

```bash
docker run -d \
    --restart always \
    --name 'apcupsd-mqtt' \
    -e UPS_ALIAS='garage' \
    -e MQTT_HOST='mqtt.home' \
    -e MQTT_USER='username' \
    -e MQTT_PASSWORD='password' \
    -e APCUPSD_HOST='apc.home' \
    ghcr.io/amargo/apcupsd-mqtt
```

## Home Assistant Integration

This application automatically configures sensors in Home Assistant using MQTT discovery. The sensors will appear under a device named according to your `UPS_ALIAS` setting.

### Available Sensors

- UPS status
- Battery charge percentage
- Battery voltage
- Input voltage
- Load percentage
- Time left on battery
- Transfer count
- Last transfer reason
- And many more (configurable in `config.yml`)

## Troubleshooting

### Duplicate Devices in Home Assistant

If you're seeing duplicate devices in Home Assistant after restarting the Docker container:

1. Make sure you're using the latest version of this application
2. Set a consistent `UPS_ALIAS` value in your environment variables
3. Remove the duplicate devices from Home Assistant

## Development

### Requirements

- Python 3.12+
- APCUPSD running and accessible
- MQTT broker

### Local Development

1. Clone the repository
2. Install dependencies: `pip install -r src/requirements.txt`
3. Run the application: `python src/apcupsd-mqtt.py`

## License

This project is licensed under the MIT License - see the LICENSE file for details.
