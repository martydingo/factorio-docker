#!/bin/bash

if [[ $FACTORIO_SERVER_GEN_CONFIG == true ]]; 
then \
        cp -v --no-clobber /opt/factorio/data/server-settings.example.json /config/server-settings.json
    	cp -v --no-clobber /opt/factorio/data/map-gen-settings.example.json /config/map-gen-settings.json
    	cp -v --no-clobber /opt/factorio/data/server-whitelist.example.json /config/server-whitelist.json
    	cp -v --no-clobber /opt/factorio/data/map-settings.example.json /config/map-settings.json
        echo "Example configurations have been copied to /config"
        echo "Container will now sleep"
        sleep 86400
else \

        if [[ $FACTORIO_SERVER_LOAD_LATEST == true ]];
        then \
                /opt/factorio/bin/x64/factorio \
                --server-settings /config/server-settings.json \
                --start-server-load-latest
        fi
        if [[ $FACTORIO_SERVER_GEN_MAP == true ]];
        then \
                if [[ $FACTORIO_SERVER_USE_MAPGEN_SETTINGS == true ]];
                then \
                        if [[ $FACTORIO_SERVER_USE_MAP_SETTINGS == true ]];
                        then \
                                echo 'FACTORIO_SERVER_USE_MAP_SETTINGS & FACTORIO_SERVER_USE_MAPGEN_SETTINGS'
                        else
                                echo 'FACTORIO_SERVER_USE_MAPGEN_SETTINGS'
                        fi
                else
                        echo 'FACTORIO_SERVER_USE_MAPGEN_SETTINGS FALSE'
                fi
        fi
fi

