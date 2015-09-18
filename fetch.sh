#!/bin/bash
python $OP_CONFIG_PATH/fetch_op_config.py ${OP_CONFIG_FILE:-op.cfg}
if ! [ -a $OP_CONFIG_PATH/op.cfg ]
then
  echo 'could not get op config file'
  echo '[op]' > $OP_CONFIG_PATH/op.cfg
fi
