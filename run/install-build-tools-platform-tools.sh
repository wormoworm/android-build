#!/bin/bash

# Install specified build-tools and platforms.
default_build_tools="build-tools;30.0.3"
default_sdk_platforms="platforms;android-30"
if [ -z "$SDK_BUILD_TOOLS" ]
then
    sdk_build_tools=${default_sdk_platforms}
else
    sdk_build_tools=$SDK_BUILD_TOOLS
fi
if [ -z "$SDK_PLATFORMS" ]
then
    sdk_platforms=${default_sdk_platforms}
else
    sdk_platforms=$SDK_PLATFORMS
fi
sdkmanager ${sdk_build_tools}
sdkmanager ${sdk_platforms}