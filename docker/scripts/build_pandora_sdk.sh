#!/bin/bash
set -e # script must exit if an error occurs

source /pandora/set_compiler_flags.sh

# Build project
mkdir build
cd build
cmake -DCMAKE_MODULE_PATH=/pandora/PandoraPFA/cmakemodules ..

if [[ "$1" == "coverity" ]]; then
    source /pandora/prepend_coverity_path.sh -fPIC
    cov-build --dir cov-int make -j2
    tar czvf coverity_build.tgz cov-int
else
    make -j2 install
fi

cd /pandora
