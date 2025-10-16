#!/bin/sh
#
# AdGuardHome 启动脚本
#

ADGH_BIN="/usr/bin/adguardhome"
ADGH_DIR="/etc/storage/adguardhome"
ADGH_LOG="/tmp/adguardhome.log"

start() {
    echo "[AdGuardHome] Starting..."
    mkdir -p $ADGH_DIR
    # 如果没有配置文件，初始化
    if [ ! -f "$ADGH_DIR/AdGuardHome.yaml" ]; then
        echo "[AdGuardHome] No config found, initializing..."
        $ADGH_BIN --work-dir $ADGH_DIR --no-check-update --config $ADGH_DIR/AdGuardHome.yaml --install
    fi
    # 启动服务
    $ADGH_BIN --work-dir $ADGH_DIR --no-check-update --config $ADGH_DIR/AdGuardHome.yaml >> $ADGH_LOG 2>&1 &
}

stop() {
    echo "[AdGuardHome] Stopping..."
    killall adguardhome 2>/dev/null
}

restart() {
    stop
    sleep 1
    start
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac
