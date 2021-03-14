#!/bin/bash
yum -y install git gcc
groupadd telegraf
useradd -s /bin/nologin -g telegraf -d /opt/telegraf telegraf
cd /opt/telegraf
git clone https://github.com/influxdata/telegraf.git
cd telegraf
make
./telegraf config > telegraf.conf
chown -R telegraf:telegraf /opt/telegraf
cat > /etc/systemd/system/telegraf.service <<EOF
[Unit]
Description=The plugin-driven server agent for reporting metrics into InfluxDB
Documentation=https://github.com/influxdata/telegraf
After=network.target

[Service]
EnvironmentFile=-/opt/telegraf/telegraf
User=telegraf
ExecStart=/opt/telegraf/telegraf/telegraf -config /opt/telegraf/telegraf/telegraf.conf $TELEGRAF_OPTS
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
RestartForceExitStatus=SIGPIPE
KillMode=control-group

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start telegraf
systemctl enable telegraf
systemctl status telegraf