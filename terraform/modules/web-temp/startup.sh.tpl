#!/bin/bash

sed -i "s|NLB_IP|${NLB_IP}|g" /etc/apache2/sites-available/000-default.conf
systemctl restart apache2

