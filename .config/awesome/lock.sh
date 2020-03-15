#!/usr/bin/env bash

exec xautolock -detectsleep \
     -time 25 -locker "i3lock -c 424047" \
     -notify 30 \
     -notifier "notify-send -u critical -t 5000 -- 'LOCKING screen in 30 seconds'"
