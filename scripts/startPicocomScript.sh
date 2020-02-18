#!/bin/bash
cat "getIpBoard.sh" | /home/stivvo/prog/picocom/./picocom -qrx 1000 -b 115200 -r -l /dev/ttyUSB0 > file
echo $(tail -n 2 file | head -n 1)
rm file
