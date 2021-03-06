#!/usr/bin/env bats

load test_helpers

. $(dirname $BATS_TEST_DIRNAME)/lib/commands/reshim.sh
. $(dirname $BATS_TEST_DIRNAME)/lib/commands/install.sh

setup() {
  setup_asdf_dir
  install_dummy_plugin
}

teardown() {
  clean_asdf_dir
}

@test "install_command installs the correct version" {
  run install_command dummy 1.1
  [ "$status" -eq 0 ]
  [ $(cat $ASDF_DIR/installs/dummy/1.1/version) = "1.1" ]
}

@test "install_command set ASDF_CONCURRENCY" {
  run install_command dummy 1.0
  [ "$status" -eq 0 ]
  [ -f $ASDF_DIR/installs/dummy/1.0/env ]
  run grep ASDF_CONCURRENCY $ASDF_DIR/installs/dummy/1.0/env
  [ "$status" -eq 0 ]
}
