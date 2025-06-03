#!/bin/sh
set -e

USER_ID=${UID:-1000}
GROUP_ID=${GID:-1000}

if [ "$SKIP_CHOWN" != "true" ]; then
  echo "Fixing file permissions with UID=${USER_ID} and GID=${GROUP_ID}..."
  chown -R ${USER_ID}:${GROUP_ID} /var/www || echo "Some files could not be changed"
else
  echo "Skipping chown due to SKIP_CHOWN=true"
fi

echo "Clearing configurations..."
php artisan config:clear
php artisan route:clear
php artisan view:clear

exec "$@"
