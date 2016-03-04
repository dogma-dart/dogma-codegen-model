#!/bin/sh
set -ex

# Clone dogma libraries
git clone https://github.com/dogma-dart/dogma-convert.git ../dogma-convert
git clone https://github.com/dogma-dart/dogma-source-analyzer.git ../dogma-source-analyzer
git clone https://github.com/dogma-dart/dogma-codegen.git ../dogma-codegen
git clone https://github.com/dogma-dart/dogma-codegen-test.git ../dogma-codegen-test

# Get version
dart --version

# Install dependencies
pub install

# Run the tests
pub global activate coverage
OBSERVATORY_PORT=8000
COVERAGE_OUTPUT=coverage.json

dart --checked --observe=${OBSERVATORY_PORT} test/all.dart & \
pub global run coverage:collect_coverage \
    --port=${OBSERVATORY_PORT} \
    --out ${COVERAGE_OUTPUT} \
    --wait-paused \
    --resume-isolates & \
wait

pub global run coverage:format_coverage \
    --package-root=packages \
    --report-on lib \
    --in ${COVERAGE_OUTPUT} \
    --out lcov.info \
    --lcov

# Verify that the libraries are error and warning-free.
#dartanalyzer ${DARTANALYZER_FLAGS} \
#    lib/convert.dart \
#    lib/serialize.dart
