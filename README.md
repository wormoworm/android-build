# Android build

## What is it?
A Docker container that builds Android apps.

## Why is it?
I wanted a repeatable way to build all my Android projects.

## What does it do?
The container provides an Ubuntu environment that is set-up ready for building any Android project that is hosted on a remote Git server. When launched, it will:
1. Checkout the specified repository.
1. Install the specified android SDK `build-tools` and  `platform-tools`.
1. Run any other scripts that are provided.

## It looks like this container supports Azure DevOps pipelines?
It does indeed. The `label` layer in the DockerFile enables integration with DevOps pipelines.
To run on DevOps, set the `container` block in your pipeline YAML file as follows:
```yaml
container:
  image: tomhomewood/android-build:latest
```
After this, add steps as usual. The step below would assemble the app for example:
```yaml
steps:
- task: Bash@3
  displayName: 'Assemble Android app'
  inputs:
    filePath: './gradlew'
    arguments: 'app:assembleRelease'
    workingDirectory: '/work/'
```

## Can I also run it locally or on my own server?
Yes. In this case you will run the container via `docker run` or `docker-compose` and provide your own build steps, in the form of a set of scripts. Below is an example of a compose file that will run the container and execute a simple script to assemble the app:
```yaml
version: "2.2"

services:
  android-build:
    image: tomhomewood/android-build:latest
    container_name: android-build
    command: /scripts/entrypoint-local.sh
    environment:
      - GIT_REPOSITORY=https://github.com/wormoworm/jmri-roster-android.git
    volumes:
      - $PWD/scripts_local:/scripts/local/
```
_This example mirrors what can be found in the [example](example) directory_.

## What environment variables can I set?
+ **GIT_REPOSITORY**: URL to the Git repo. Mandatory. **Only used for local builds**.
+ **GIT_BRANCH**: Branch to checkout. Optional, defaults to "master". **Only used for local builds**.
+ **SDK_BUILD_TOOLS**: Version of Android SDK build-tools to install. Optional, defaults to "build-tools;30.0.3". Can be used for both local and DevOps builds, but DevOps will only use this information if you run `/scripts/entrypoint-devops-pipelines.sh` in a script step in your pipeline.
+ **SDK_PLATFORMS**: Android SDK platform to install. Optional, defaults to "platforms;android-30". Can be used for both local and DevOps builds, but DevOps will only use this information if you run `/scripts/entrypoint-devops-pipelines.sh` in a script step in your pipeline.

You may of course set any other environment variables you need to (login tokens, AWS options, etc etc).
