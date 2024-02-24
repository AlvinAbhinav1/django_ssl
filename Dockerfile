FROM python:3.11-alpine
ENV PYTHONUNBUFFERED 1

RUN apk add --upgrade --no-cache build-base gcc musl-dev linux-headers mariadb-dev

COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip && \
    pip install -r /requirements.txt

COPY src/ /src
WORKDIR /src

RUN adduser --disabled-password --no-create-home django

USER django

CMD ["uwsgi", "--socket", ":9000", "--workers", "4", "--master", "--enable-threads", "--module", "app.wsgi"]
