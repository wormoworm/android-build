#!/bin/bash
# A wrapper script that can be invoked using a script step as part of a DevOps pipeline. Takes care of the necesary housekeeping that needs to be run before the app can be built. Performs the following tasks:
# 1: Install specified build-tools and platforms. These are set using the environment variables SDK_PLATFORMS and SDK_BUILD_TOOLS, and currently default to platforms;android-30 and build-tools;30.0.3 respectively.

# 1: Install specified build-tools and platforms.
/scripts/install-build-tools-platform-tools.sh