#!/bin/bash
# Create User
# Create Group
# Install Telegraf
yum -y install git
cd /opt
git clone https://github.com/influxdata/telegraf.git /opt/telegraf
cd /opt/telegraf
make