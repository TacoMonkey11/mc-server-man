#!usr/bin/env bash
filename=
memory=
modloader=

flags="java -jar -server -XX:+UseLargePages -XX:LargePageSizeInBytes=2M -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC -XX:ShenandoahGCMode=iu -XX:+UseNUMA -XX:+AlwaysPreTouch -XX:-UseBiasedLocking -XX:+DisableExplicitGC -Dfile.encoding=UTF-8 launcher-airplane.jar --nogui"

echo "Starting your ${modloader} server in a new screen instance"
screen -t java ${memory} ${flags} -jar ${filename}