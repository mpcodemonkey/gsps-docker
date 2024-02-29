#!/bin/sh

# my cheaty way of moving the config.json outside of the container.
if [ -d ./config ];
then
 echo "copying grasscutter config from /config directory..."
 cp ./config/config.json .
else
 echo "no config provided. suit yourself."
fi

# Game Server
java -Dfile.encoding=UTF-8 -jar grasscutter.jar