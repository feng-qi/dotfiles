#!/usr/bin/env bash

exec xautolock -detectsleep \
     -time 15 -locker "i3lock -c 007000" \
     -notify 30 \
     -notifier "notify-send -u critical -t 5000 -- 'LOCKING screen in 30 seconds'"
