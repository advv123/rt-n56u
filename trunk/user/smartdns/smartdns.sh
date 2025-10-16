#!/bin/sh
# SmartDNS 启动脚本 (适配 Release47)

SMARTDNS_BIN=/usr/bin/smartdns
SMARTDNS_CONF=/etc/storage/smartdns.conf
SMARTDNS_CUSTOM=/etc/storage/smartdns_custom.conf
SMARTDNS_LOG=/var/log/smartdns.log
SMARTDNS_PID=/var/run/smartdns.pid

start_smartdns() {
    echo "[SmartDNS] 启动中..."

    # 如果没有配置文件，生成一个最小配置
    if [ ! -f "$SMARTDNS_CONF" ]; then
        cat > "$SMARTDNS_CONF" <<EOF
bind [::]:6053
cache-size 512
server 119.29.29.29
server 223.5.5.5
EOF
    fi

    # 合并自定义配置
    CONF_TMP=/tmp/smartdns.conf
    cp "$SMARTDNS_CONF" "$CONF_TMP"
    [ -f "$SMARTDNS_CUSTOM" ] && cat "$SMARTDNS_CUSTOM" >> "$CONF_TMP"

    # 启动 SmartDNS
    $SMARTDNS_BIN -c "$CONF_TMP" -p "$SMARTDNS_PID" > "$SMARTDNS_LOG" 2>&1 &
    echo "[SmartDNS] 已启动，日志: $SMARTDNS_LOG"
}

stop_smartdns() {
    echo "[SmartDNS] 停止中..."
    [ -f "$SMARTDNS_PID" ] && kill "$(cat $SMARTDNS_PID)" 2>/dev/null
    rm -f "$SMARTDNS_PID"
}

restart_smartdns() {
    stop_smartdns
    sleep 1
    start_smartdns
}

case "$1" in
    start) start_smartdns ;;
    stop) stop_smartdns ;;
    restart) restart_smartdns ;;
    *) echo "用法: $0 {start|stop|restart}" ;;
esac
