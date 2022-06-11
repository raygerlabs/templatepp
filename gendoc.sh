#!/bin/bash
mkdir -p tmp/build
cmake -DBUILD_DOC:BOOL=TRUE -Btmp/build
pushd tmp/build
cmake --build . --target doxydoc pdfdoc
popd
