#!/bin/bash

# Node Exporter setup script for RHEL 6
set -e

echo "Starting Node Exporter installation..."

# Create user if not exists
if ! id -u node_exporter &>/dev/null; then
    useradd -r -s /sbin/nologin -c "Node Exporter User" node_exporter
fi

# Create installation directory
mkdir -p /opt/node_exporter

# Extract node exporter
tar xzf /tmp/node_exporter-1.3.1.linux-amd64.tar.gz -C /opt/node_exporter/

# Create symlink
ln -sf /opt/node_exporter/node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/node_exporter

# Create init script
cat > /etc/init.d/node_exporter << 'EOF'
#!/bin/bash
#
# node_exporter   Start/Stop the node_exporter
#
# chkconfig: 2345 85 15
# description: Prometheus Node Exporter

PROG="/usr/local/bin/node_exporter"
USER="node_exporter"
LOG_FILE="/var/log/node_exporter.log"

start() {
    echo -n $"Starting node_exporter: "
    daemon --user $USER "$PROG --web.listen-address=:9100 > $LOG_FILE 2>&1 &"
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && touch /var/lock/subsys/node_exporter
    return $RETVAL
}

stop() {
    echo -n $"Stopping node_exporter: "
    killproc $PROG
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/node_exporter
    return $RETVAL
}

case "$1" in
    start) start ;;
    stop) stop ;;
    restart) stop; start ;;
    status) status $PROG ;;
    *) echo $"Usage: $0 {start|stop|restart|status}"; exit 2 ;;
esac
EOF

# Make init script executable
chmod 755 /etc/init.d/node_exporter

# Add to chkconfig
chkconfig --add node_exporter
chkconfig node_exporter on

# Start service
service node_exporter start

echo "Node Exporter installation completed!"
echo "Check status with: service node_exporter status"
echo "Access metrics on: http://$(hostname -I | awk '{print $1}'):9100/metrics"
