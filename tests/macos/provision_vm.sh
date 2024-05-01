#!/bin/zsh

THIS_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd $THIS_DIR/macos-test-vm

xcodebuild -configuration Debug -scheme InstallationTool-Swift
xcodebuild -configuration Debug -scheme macOSVirtualMachineSampleApp-Swift

cd ../

# Check if VM.bundle exists, build it if not
if [ ! -d "VM.bundle" ]; then
    echo "VM.bundle not found, building it..."
    ./macos-test-vm/Build/macOSVirtualMachineSampleApp/Build/Products/Debug/InstallationTool-Swift
fi

./macos-test-vm/Build/macOSVirtualMachineSampleApp/Build/Products/Debug/macOSVirtualMachineSampleApp.app/Contents/MacOS/macOSVirtualMachineSampleApp
