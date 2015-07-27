#!/bin/bash
aws s3 cp s3://${OP_CONFIG_BUCKET}/${OP_CONFIG_FILE:-op.cfg} $OP_CONFIG_PATH/op.cfg
if ! [ -a $OP_CONFIG_PATH/op.cfg ]
then
  echo 'could not get op config file'
  echo '[op]' > $OP_CONFIG_PATH/op.cfg
fi
