#!/bin/bash
# Installs the base Android SDK components, including the command-line tools.

# Download and extract the tools.
wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
unzip commandlinetools-linux-6609375_latest.zip -d cmdline-tools
rm commandlinetools-linux-6609375_latest.zip
sudo mv cmdline-tools $ANDROID_HOME/

# Remove rogue debian directory (may not be needed?).
sudo rm -rf ${ANDROID_HOME}/build-tools/debian/

# Move to the command tools bin directory (we have not yet added it to $PATH but we want to use the sdkmanager)
cd $ANDROID_HOME/cmdline-tools/tools/bin

# Accept SDK licenses
yes | ./sdkmanager --licenses

# Install the platform tools
./sdkmanager "platform-tools"
# Install the Android and Google m2 repositories
./sdkmanager "extras;android;m2repository"
./sdkmanager "extras;google;m2repository"
# Install Google Play Services
./sdkmanager "extras;google;google_play_services"