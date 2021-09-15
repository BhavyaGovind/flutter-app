#!/usr/bin/env bash
#Place this script in project/android/app/

cd ..

# fail if any command fails
set -e
# debug log
set -x

cd ..
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

flutter channel stable
flutter doctor

# Set APP_CENTER_VERSION_MODIFIER if you want to modify the version name
# to x.y.z-${APP_CENTER_VERSION_MODIFIER}
BUILD_NAME=$(grep -E '^version' pubspec.yaml | cut -d':' -f2 | tr -d '[:space:]')
if [ ! -z "$APPCENTER_BUILD_ID" ]
then
  BUILD_NAME=${BUILD_NAME}.${APPCENTER_BUILD_ID}
fi
if [ ! -z "$APP_CENTER_VERSION_MODIFIER" ]
then
  BUILD_NAME=${BUILD_NAME}-${APP_CENTER_VERSION_MODIFIER}
fi
./update-app-settings.sh

flutter build apk --release --build-name=${BUILD_NAME} -t lib/main.dart

mkdir -p android/app/build/outputs/apk/
mv build/app/outputs/flutter-apk/app-release.apk $_