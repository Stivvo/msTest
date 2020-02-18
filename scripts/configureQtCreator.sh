#!/bin/bash
./startPicocom.sh
IP="$(/home/stivvo/prog/msTest/scripts/./startPicocomScript.sh)"
IP=${IP::-1}
echo $IP

CONFF="/home/stivvo/.config/QtProject/qtcreator/devices.xml"
sed -i "s/192.168.0.1/${IP}/g" $CONFF
#sed -i "s/^M//g" $CONFF
#vim $CONFF
/home/stivvo/Qt/Tools/QtCreator/bin/./qtcreator.sh
sed -i "s/${IP}/192.168.0.1/g" $CONFF
