#!/usr/bin/env bash

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java
sdk install sbt
sdk install scala
