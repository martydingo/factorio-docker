#!/bin/bash

if [[ -z `ls /config` ]]; 
then \
        cp -v --no-clobber /opt/factorio/data/server-settings.example.json /config/server-settings.json
    	cp -v --no-clobber /opt/factorio/data/map-gen-settings.example.json /config/map-gen-settings.json
    	cp -v --no-clobber /opt/factorio/data/server-whitelist.example.json /config/server-whitelist.json
    	cp -v --no-clobber /opt/factorio/data/map-settings.example.json /config/map-settings.json
        echo "Example configurations have been copied to /config.. server will use these configurations on the next restart of the container"
        echo "Container will now sleep for 3600 seconds before restarting"
        sleep 3600
else \
        cp -v /config/server-settings.json /opt/factorio/data/server-settings.json
        cp -v /config/map-gen-settings.json /opt/factorio/data/map-gen-settings.json
        cp -v /config/server-whitelist.json /opt/factorio/data/server-whitelist.json
        cp -v /config/map-gen-settings.json /opt/factorio/data/map-settings.json
        
        /opt/factorio/bin/x64/factorio \
        --start-server \
        --server-settings /opt/factorio/data/server-settings.json \
        --map-settings /opt/factorio/data/map-settings.json \
        --map-gen-settings /opt/factorio/data/map-gen-settings.json 
fi

