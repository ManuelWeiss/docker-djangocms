#!/bin/bash

: ${CMS_ADMIN_USERNAME:?ERROR: Please set CMS_ADMIN_USERNAME in env}
: ${CMS_ADMIN_EMAIL:?ERROR: Please set CMS_ADMIN_EMAIL in env}
: ${CMS_ADMIN_PASSW:?ERROR: Please set CMS_ADMIN_PASSW in env}

python manage.py createsuperuser --username=$CMS_ADMIN_USERNAME --email=$CMS_ADMIN_EMAIL --noinput
python manage.py shell <<EOF
from django.contrib.auth.models import User
u = User.objects.get(username__exact="$CMS_ADMIN_USERNAME")
u.set_password("$CMS_ADMIN_PASSW")
u.save()
EOF
