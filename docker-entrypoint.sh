#!/bin/bash

if [[ $FACTORIO_SERVER_GEN_CONFIG == true ]]; 
then \
        cp -v --no-clobber /opt/factorio/data/server-settings.example.json /config/server-settings.json
    	cp -v --no-clobber /opt/factorio/data/map-gen-settings.example.json /config/map-gen-settings.json
    	cp -v --no-clobber /opt/factorio/data/server-whitelist.example.json /config/server-whitelist.example.json
    	cp -v --no-clobber /opt/factorio/data/map-settings.example.json /config/map-settings.json
        echo "Example configurations have been copied to /config"
        echo "Container will now sleep"
        sleep 86400
else \
        if [[ ! -f /config/server-settings.json ]];
        then \
                echo '-----'
                echo 'FATAL: /config/server-settings.json not found.'  
                echo 'Either generate configurations by configuring the environment variable' 
                echo 'within the Docker/Kubernetes configuration: FACTORIO_SERVER_GEN_CONFIG=true' 
                echo '-----'
                echo 'or mount a configuration containing server-settings.json at /config' 
                echo './config:/config'
                echo 'along with any additional configurations as required'
                echo '-----'
                exit 1
        fi

        if [[ $FACTORIO_SERVER_LOAD_LATEST == true ]];
        then \
                /opt/factorio/bin/x64/factorio \
                --mod-directory /mods \
                --server-settings /config/server-settings.json \
                --start-server-load-latest
        else
                if [[ $FACTORIO_SERVER_GEN_MAP == true ]];
                then \
                        if [[ $FACTORIO_SERVER_USE_MAPGEN_SETTINGS == true ]];
                        then \
                                if [[ $FACTORIO_SERVER_USE_MAP_SETTINGS == true ]];
                                then \
                                        /opt/factorio/bin/x64/factorio \
                                        --mod-directory /mods \
                                        --server-settings /config/server-settings.json \
                                        --map-gen-settings /config/map-gen-settings.json \
                                        --map-settings /config/map-settings.json \
                                        --create /opt/factorio/saves/`date +%Y-%m-%d_%H-%M-%`
                                else
                                        /opt/factorio/bin/x64/factorio \
                                        --mod-directory /mods \
                                        --server-settings /config/server-settings.json \
                                        --map-gen-settings /config/map-gen-settings.json \
                                        --create /opt/factorio/saves/`date +%Y-%m-%d_%H-%M-%`
                                fi
                        else
                                echo 'FACTORIO_SERVER_USE_MAPGEN_MAP_SETTINGS FALSE'
                                        /opt/factorio/bin/x64/factorio \
                                        --mod-directory /mods \
                                        --server-settings /config/server-settings.json \
                                        --create /opt/factorio/saves/`date +%Y-%m-%d_%H-%M-%`
                        fi
                fi
        fi      
fi

