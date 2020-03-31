from django.contrib.auth.middleware import RemoteUserMiddleware

class CustomRemoteUser(RemoteUserMiddleware):
    header = 'HTTP_X_FORWARDED_USER'