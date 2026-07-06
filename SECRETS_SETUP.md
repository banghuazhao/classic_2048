# Secrets Setup Guide

This project uses build-time injection for sensitive values (like AdMob IDs). Follow these steps to set up your local environment.

## Android Setup

1. Copy `android/secrets.properties.template` to `android/secrets.properties`.
2. Fill in the real production AdMob IDs in `android/secrets.properties`.
3. The build script will automatically load these values for `release` builds. `debug` builds use Google's official test IDs by default.

## iOS Setup

1. Create a file named `ios/Runner/Secrets-Release.xcconfig`.
2. Add your production AdMob IDs to this file:
   ```xcconfig
   GAD_APPLICATION_IDENTIFIER = ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX
   ADMOB_BANNER_ID = ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX
   ADMOB_APPOPEN_ID = ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX
   ```
3. This file is ignored by git and will be used only during `release` builds. `debug` builds use the test IDs defined in `ios/Runner/Secrets.xcconfig`.

## Note on Version Control
Never commit `secrets.properties` or `Secrets-Release.xcconfig` to git. They are already added to `.gitignore`.
