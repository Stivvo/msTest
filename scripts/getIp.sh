#!/bin/sh
echo $(ifconfig | head -n 2 | tail -n -1 | awk '{print $2}')
