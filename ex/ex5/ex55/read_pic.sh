#!/bin/bash
mkdir -p fig
rm -f fig/*
scp root@192.168.1.10:/home/httpd/out* fig/
