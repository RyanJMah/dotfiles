#!/bin/zsh

THIS_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd $THIS_DIR/macos-test-vm

rm -rf Build

xcodebuild -configuration Debug -scheme InstallationTool-Swift
xcodebuild -configuration Debug -scheme macOSVirtualMachineSampleApp-Swift
