#!/bin/sh

## Enable timezone Conatiner
echo ""
echo "Time zone update to: " $TZ
cat /usr/share/zoneinfo/$TZ > /etc/localtime
echo ""
echo $TZ > /etc/timezone

# Start Python
set -e

dir=/app/venv/lib/python3.13/site-packages

if [ -d $dir ]; then
	echo ""
	echo "Iniciando APP..."
	echo ""
else
    cd /app\
    && python3 -m venv venv\
    && . venv/bin/activate\
    && pip install -r requirements.txt\
    && echo ""\
    && python manage.py migrate\
    ; python manage.py collectstatic --noinput\
    ; echo ""\
    && pip install uwsgi
fi

cd /app && . venv/bin/activate\
&& uwsgi --master --emperor /sites
#&& python manage.py runserver 0.0.0.0:8001
