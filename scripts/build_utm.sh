set -e

if [ -z $UTM_VERSION ]
then
  echo "missing variable UTM_VERSION"
  exit 1
fi

UTM_TAG=utm_$UTM_VERSION

echo MACOSX_DEPLOYMENT_TARGET=$MACOSX_DEPLOYMENT_TARGET

git clone https://gitlab.cern.ch/cms-l1t-utm/utm.git -b $UTM_TAG
cd utm

./configure
make all CPPFLAGS="-DNDEBUG -DSWIG" -j4
cd ..
