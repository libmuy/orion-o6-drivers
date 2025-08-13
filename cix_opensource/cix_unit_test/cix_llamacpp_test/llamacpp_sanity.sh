#!/bin/sh

if [ $# = 0 ]; then
    echo "Usage:"
    echo "./llamacpp_sanity.sh server path/to/model.gguf"
    echo "./llamacpp_sanity.sh cli path/to/model.gguf"
    exit 1
fi

# cd /usr/share/cix/bin

if  [ $1 = "server" ]; then
    hostname=$(hostname -I | awk '{print $1}')
    taskset -c 0,5,6,7,8,9,10,11 /usr/share/cix/bin/llama-server -m $2 -t 8 -c 4096 --host $hostname --port 8080
fi
if  [ $1 = "cli" ]; then
    taskset -c 0,5,6,7,8,9,10,11 /usr/share/cix/bin/llama-cli -m $2 -t 8 -c 4096 --conversation
fi

