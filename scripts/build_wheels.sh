#!/bin/bash

set -e

BOOST_BASE=$(pwd)/dist/boost
XERCES_C_BASE=$(pwd)/dist/xerces-c
UTM_BASE=$(pwd)/dist/utm
export REPAIR_LIBRARY_PATH=${UTM_BASE}/lib:${BOOST_BASE}/lib:${XERCES_C_BASE}/lib}

MODULES="tm-eventsetup tm-grammar tm-table"

for MODULE in $MODULES
do
  echo " ==> $MODULE"
  git clone https://github.com/cms-l1-globaltrigger/$MODULE.git -b $UTM_VERSION
  cd $MODULE
  echo " ===> $MODULE build wheel..."
  python -m cibuildwheel --output-dir ../wheelhouse
  cd ..
done
