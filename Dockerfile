FROM alpine:3.11

RUN apk add bash python3 python3-dev postgresql-dev zlib-dev gcc jpeg-dev libxml2-dev libxslt-dev libc-dev git nginx
RUN apk add --no-cache tini

ADD https://api.github.com/repos/vabene1111/recipes/git/refs/heads/develop version.json
RUN git clone -b develop https://github.com/vabene1111/recipes.git 

# RUN git clone https://github.com/vabene1111/recipes/

WORKDIR /recipes
ADD ./settings.py /recipes/recipes/settings.py
ADD ./middleware.py /recipes/recipes/utilities/middleware.py
ADD ./start.sh /recipes/start.sh
ADD ./media.conf /etc/nginx/conf.d/media.conf

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r requirements.txt


ENV PYTHONUNBUFFERED 1

EXPOSE 8080 8081

ENTRYPOINT ["/sbin/tini", "--"]

CMD [ "bash", "/recipes/start.sh" ]
