#!/usr/bin/env bash

# Prepare directory for Zend_Log to write to
mkdir -p /var/log/apache2/www.hhbd.pl
chown www-data: /var/log/apache2/www.hhbd.pl
