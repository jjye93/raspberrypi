#!/usr/bin/bash
sudo apt install transmission-daemon -y
sudo systemctl stop transmission-daemon
sudo systemctl disable transmission-daemon
sudo mkdir ~/Download/.transmission
sudo rm /etc/transmission-daemon/settings.json
cat << EOF | sudo tee /etc/transmission-daemon/settings.json > /dev/null
{
    "alt-speed-down": 50,
    "alt-speed-enabled": false,
    "alt-speed-time-begin": 540,
    "alt-speed-time-day": 127,
    "alt-speed-time-enabled": false,
    "alt-speed-time-end": 1020,
    "alt-speed-up": 50,
    "bind-address-ipv4": "0.0.0.0",
    "bind-address-ipv6": "::",
    "blocklist-enabled": false,
    "blocklist-url": "http://www.example.com/blocklist",
    "cache-size-mb": 4,
    "dht-enabled": true,
    "download-dir": "~/Downloads/",
    "download-limit": 100,
    "download-limit-enabled": 0,
    "download-queue-enabled": true,
    "download-queue-size": 5,
    "encryption": 1,
    "idle-seeding-limit": 30,
    "idle-seeding-limit-enabled": false,
    "incomplete-dir": "~/Downloads/.transmission/",
    "incomplete-dir-enabled": false,
    "lpd-enabled": false,
    "max-peers-global": 200,
    "message-level": 1,
    "peer-congestion-algorithm": "",
    "peer-id-ttl-hours": 6,
    "peer-limit-global": 200,
    "peer-limit-per-torrent": 50,
    "peer-port": 51413,
    "peer-port-random-high": 65535,
    "peer-port-random-low": 49152,
    "peer-port-random-on-start": false,
    "peer-socket-tos": "default",
    "pex-enabled": true,
    "port-forwarding-enabled": false,
    "preallocation": 1,
    "prefetch-enabled": true,
    "queue-stalled-enabled": true,
    "queue-stalled-minutes": 30,
    "ratio-limit": 2,
    "ratio-limit-enabled": false,
    "rename-partial-files": true,
    "rpc-authentication-required": true,
    "rpc-bind-address": "0.0.0.0",
    "rpc-enabled": true,
    "rpc-host-whitelist": "",
    "rpc-host-whitelist-enabled": false,
    "rpc-password": "qwer1234",
    "rpc-port": 9091,
    "rpc-url": "/transmission/",
    "rpc-username": "admin",
    "rpc-whitelist": "127.0.0.1",
    "rpc-whitelist-enabled": false,
    "scrape-paused-torrents-enabled": true,
    "script-torrent-done-enabled": false,
    "script-torrent-done-filename": "",
    "seed-queue-enabled": false,
    "seed-queue-size": 10,
    "speed-limit-down": 100,
    "speed-limit-down-enabled": false,
    "speed-limit-up": 100,
    "speed-limit-up-enabled": false,
    "start-added-torrents": true,
    "trash-original-torrent-files": false,
    "umask": 22,
    "upload-limit": 100,
    "upload-limit-enabled": 0,
    "upload-slots-per-torrent": 14,
    "utp-enabled": true
}    
EOF

sudo rm /etc/init.d/transmission-daemon

cat << EOF | sudo tee /etc/init.d/transmission-daemon > /dev/null
#!/bin/sh -e
### BEGIN INIT INFO
# Provides:          transmission-daemon
# Required-Start:    $local_fs $remote_fs $network
# Required-Stop:     $local_fs $remote_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start or stop the transmission-daemon.
# Description:       Enable service provided by transmission-daemon.
### END INIT INFO

NAME=transmission-daemon
DAEMON=/usr/bin/$NAME
USER=$USER
STOP_TIMEOUT=30

export PATH="${PATH:+$PATH:}/sbin"

[ -x $DAEMON ] || exit 0

[ -e /etc/default/$NAME ] && . /etc/default/$NAME

. /lib/lsb/init-functions

start_daemon () {
    if [ $ENABLE_DAEMON != 1 ]; then
        log_progress_msg "(disabled)"
                log_end_msg 255 || true
    else    
        start-stop-daemon --start \
        --chuid $USER \
                $START_STOP_OPTIONS \
        --exec $DAEMON -- $OPTIONS || log_end_msg $?
                log_end_msg 0
    fi
}

case "$1" in
    start)
        log_daemon_msg "Starting bittorrent daemon" "$NAME"
        start_daemon
        ;;
    stop)
        log_daemon_msg "Stopping bittorrent daemon" "$NAME"
        start-stop-daemon --stop --quiet \
            --exec $DAEMON --retry $STOP_TIMEOUT \
            --oknodo || log_end_msg $?
        log_end_msg 0
        ;;
    reload)
        log_daemon_msg "Reloading bittorrent daemon" "$NAME"
        start-stop-daemon --stop --quiet \
            --exec $DAEMON \
            --oknodo --signal 1 || log_end_msg $?
        log_end_msg 0
        ;;
    restart|force-reload)
        log_daemon_msg "Restarting bittorrent daemon" "$NAME"
        start-stop-daemon --stop --quiet \
            --exec $DAEMON --retry $STOP_TIMEOUT \
            --oknodo || log_end_msg $?
        start_daemon
        ;;
    status)
        status_of_proc "$DAEMON" "$NAME" && exit 0 || exit $?
        ;;
    *)
        log_action_msg "Usage: /etc/init.d/$NAME {start|stop|reload|force-reload|restart|status}" || true
        exit 2
        ;;
esac

exit 0
EOF

sudo rm /etc/systemd/system/multi-user.target.wants/transmission-daemon.service

cat << EOF | sudo tee /etc/systemd/system/multi-user.target.wants/transmission-daemon.service > /dev/null

[Unit]
Description=Transmission BitTorrent Daemon
After=network.target

[Service]
User=$USER              
Type=notify
ExecStart=/usr/bin/transmission-daemon -f --log-error
ExecStop=/bin/kill -s STOP $MAINPID
ExecReload=/bin/kill -s HUP $MAINPID
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target

EOF

sudo systemctl daemon-reload
sudo chown -R $USER:$USER /etc/transmission-daemon
sudo mkdir -p /home/$USER/.config/transmission-daemon/
sudo ln -s /etc/transmission-daemon/settings.json /home/$USER/.config/transmission-daemon/
sudo chown -R $USER:$USER /home/$USER/.config/transmission-daemon/
sudo systemctl start transmission-daemon
sudo sysrtemctl enable transmission-daemon
return ;;
