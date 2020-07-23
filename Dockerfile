FROM python:3.8.2

ENV APP_NAME "site"

RUN pip install --upgrade pip

RUN mkdir /app

WORKDIR /app

ADD ./app/ /app/

RUN apt-get -y update

RUN apt-get -y install nginx

RUN pip install -r /app/requirements.txt

COPY ./docker/app/default.conf /etc/nginx/sites-available/default

EXPOSE 80

COPY ./docker/app/entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD [ "gunicorn", "--reload", "--workers 3", "--bind 0.0.0.0:8000", "$APP_NAME.wsgi:application" ]