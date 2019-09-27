#!/bin/bash

until mysqladmin ping -h mysql_host --silent; do
    echo 'waiting for mysqld to be connectable...'
    sleep 3
done