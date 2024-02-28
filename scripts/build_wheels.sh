#!/bin/bash

set -e

: ${UTM_VERSION:=0.12.0}
: ${BOOST_BASE:=$(pwd)/dist/boost}
: ${XERCES_C_BASE:=$(pwd)/dist/xerces-c}
: ${UTM_BASE:=$(pwd)/dist/utm}

export REPAIR_LIBRARY_PATH=${UTM_BASE}/lib:${BOOST_BASE}/lib:${XERCES_C_BASE}/lib}

# setup.py constraint of modules
export UTM_ROOT=$(pwd)/build/utm-utm_${UTM_VERSION}
export UTM_XSD_DIR=$UTM_BASE

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
