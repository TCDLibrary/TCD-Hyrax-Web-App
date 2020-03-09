#!/bin/bash
set -e
pgrep nginx || exit 0  # short circut if no nginx
if [[ ! -e /etc/letsencrypt/live ]]; then
    certbot --nginx -d $DOCKER_HOST -m support@notch8.com --agree-tos --non-interactive
else
    certbot renew
fi
