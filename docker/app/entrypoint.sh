#!/bin/bash

python -V

# /app/manage.py migrate

# /app/manage.py collectstatic --no-input

service nginx start

# gunicorn --reload --workers 3 --bind 0.0.0.0:8000 gratuidade.wsgi:application