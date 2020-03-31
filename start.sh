cd /recipes/
python3 manage.py migrate
python3 manage.py collectstatic --noinput

/usr/bin/gunicorn -b :8080 --access-logfile - --error-logfile - recipes.wsgi