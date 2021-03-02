#!/bin/bash

source $(dirname "$0")/../../build/deploy/unix/api.sh

REL_OUTPUT_DIR=$1
REL_ARCHIVE_DIR=$2

ComponentApiBegin csillagvarta $REL_OUTPUT_DIR $REL_ARCHIVE_DIR
ComponentApiEnd

