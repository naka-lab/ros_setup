#!/bin/sh
sudo date -s "$( wget -q http://worldtimeapi.org/api/timezone/Asia/Tokyo -O - | grep -oE \"datetime\":\"[^\"]* | sed s/\"datetime\":\"// )"
