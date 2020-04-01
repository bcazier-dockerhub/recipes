cd /recipes/
python3 manage.py migrate
python3 manage.py collectstatic --noinput

if [ ! -d /run/nginx/ ]; then
    mkdir -p /run/nginx
fi

if [ -e /run/nginx/nginx.pid ]; then
    /usr/sbin/nginx -s stop

    if [ -e /run/nginx/nginx.pid ]; then
        kill -QUIT $( cat /run/nginx/nginx.pid )
    fi
fi

/usr/sbin/nginx

/usr/bin/gunicorn -b :8080 --access-logfile - --error-logfile - recipes.wsgi