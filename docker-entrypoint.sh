#!/bin/sh
set -e

while ! mysqladmin ping -hmysql -uroot -proot; do
	sleep 1
done

if [ ! -e /installed ]; then
    mysql -hmysql -uroot -proot -e 'CREATE DATABASE `edusoho` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci'
    bin/phpmig migrate
    app/console system:init
    php app/console assets:install web --symlink --relative
		touch /installed
    echo "init database - OK"
fi

cd /var/www/edusoho/
npm run compile > > app/logs/node.log 2>&1 &
echo "web is running"

exec "$@"
