set -e

source ./utm/env.sh

BUILD_DIR=$(pwd)
WHEELS=$(find $BUILD_DIR/wheelhouse -name '*.whl')

mkdir -p $BUILD_DIR/fixed_wheels

echo " ====> wheelhouse..."
ls -l $BUILD_DIR/wheelhouse

echo " ====> wheels to fix..."
echo "$WHEELS"

for WHEEL in $WHEELS
do
  echo " ==> delocate $WHEEL..."
  delocate-wheel -w $BUILD_DIR/fixed_wheels -v $WHEEL
done

echo " ====> summary..."
delocate-listdeps --all $BUILD_DIR/fixed_wheels

echo " ==> done."
