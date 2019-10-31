#!/usr/bin/env bats

@test "freeswitch is installed" {
  run docker run --rm $IMAGE which freeswitch
  [ "$status" -eq 0 ]
}

@test "freeswitch runs ok" {
  run docker run --rm $IMAGE freeswitch -help
  [ "$status" -eq 0 ]
}

