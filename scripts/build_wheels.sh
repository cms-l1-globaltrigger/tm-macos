set -e

if [ -z $UTM_VERSION ]
then
  echo "missing variable UTM_VERSION"
  exit 1
fi

MODULES="tm-eventsetup tm-grammar tm-table"

echo MACOSX_DEPLOYMENT_TARGET=$MACOSX_DEPLOYMENT_TARGET

source ./utm/env.sh

BUILD_DIR=$(pwd)

mkdir -p $BUILD_DIR/wheelhouse

for MODULE in $MODULES
do
  echo " ==> $MODULE"
  git clone https://github.com/cms-l1-globaltrigger/$MODULE.git -b $UTM_VERSION
  cd $MODULE
  echo " ===> $MODULE build wheel..."
  python -m build --no-isolation --wheel -o $BUILD_DIR/wheelhouse
  cd ..
done
