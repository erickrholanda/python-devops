#!/bin/bash
APP_NAME=$APP_NAME
echo "Iniciando $APP_NAME ..."
sleep 2

if test ! -f "/app/manage.py"; then
    django-admin startproject $APP_NAME .
fi

if test -f "/app/manage.py"; then
    /usr/sbin/sshd

    /app/manage.py migrate

    /app/manage.py collectstatic --no-input

    service nginx start

    gunicorn --reload --workers 3 --bind 0.0.0.0:8000 $APP_NAME.wsgi:application
fi;