DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
chmod 755 $DIR/op_config_tool.py
aws s3 cp s3://${OP_CONFIG_BUCKET}/${OP_CONFIG_FILE:-op.cfg} $DIR/op.cfg
alias opc="$DIR/op_config_tool.py $DIR/op.cfg"
export PYTHONPATH=$(pwd):$PYTHONPATH
