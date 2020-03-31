FROM alpine:3.11

RUN apk add bash python3 python3-dev postgresql-dev zlib-dev gcc jpeg-dev libxml2-dev libxslt-dev libc-dev git
RUN apk add --no-cache tini

RUN git clone https://github.com/vabene1111/recipes/

WORKDIR /recipes
ADD ./settings.py /recipes/recipes/settings.py
ADD ./middleware.py /recipes/recipes/utilities/middleware.py
ADD ./start.sh /recipes/start.sh

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r requirements.txt


ENV PYTHONUNBUFFERED 1

EXPOSE 8080

ENTRYPOINT ["/sbin/tini", "--"]

CMD [ "bash", "/recipes/start.sh" ]

