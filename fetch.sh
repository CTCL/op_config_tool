#!/bin/bash
python $OP_CONFIG_PATH/fetch_op_config.py $@
if ! [ -a $OP_CONFIG_PATH/op.cfg ]
then
  echo 'could not get op config file'
fi
