#!/bin/bash

set -eo pipefail

xcodebuild -scheme BTG\ Converser \
            -destination platform=iOS\ Simulator,OS=13.4.1,name=iPhone\ 11 \
            clean test | xcpretty