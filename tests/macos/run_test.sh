#!/bin/zsh

THIS_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd $THIS_DIR/macos-test-vm

rm -rf Build

xcodebuild -configuration Debug -scheme InstallationTool-Swift
xcodebuild -configuration Debug -scheme macOSVirtualMachineSampleApp-Swift

# Run the image creation tool (will generate VM.bundle in cwd)
cd ../
rm -rf VM.bundle
./macos-test-vm/Build/macOSVirtualMachineSampleApp/Build/Products/Debug/InstallationTool-Swift
