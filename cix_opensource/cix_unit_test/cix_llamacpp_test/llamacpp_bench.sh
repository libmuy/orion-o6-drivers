#!/bin/sh

if [ $# = 0 ]; then
    echo "Usage:"
    echo "./llamacpp_bench.sh bench path/to/model.gguf"
    echo "./llamacpp_bench.sh perplexity path/to/model.gguf"
    exit 1
fi

# cd /usr/share/cix/bin

if  [ $1 = "bench" ]; then
    taskset -c 0,5,6,7,8,9,10,11 /usr/share/cix/bin/llama-bench -m $2 -pg 128,128 -t 8
fi
if  [ $1 = "perplexity" ]; then
    taskset -c 0,5,6,7,8,9,10,11 /usr/share/cix/bin/llama-perplexity -m $2 -f ./wiki.test.raw -t 8
fi

