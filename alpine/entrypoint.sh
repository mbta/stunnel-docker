#!/usr/bin/env sh
echo "$STUNNEL_CONF" >> stunnel.conf
exec /usr/bin/stunnel stunnel.conf
