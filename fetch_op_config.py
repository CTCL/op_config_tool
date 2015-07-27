#!/usr/bin/env python
import sys, os
from subprocess import call
def run(remote_file=None):
    if not remote_file:
        remote_file = os.getenv("OP_CONFIG_FILE", "op.cfg")
    location = os.path.dirname(os.path.abspath(__file__))
    op_config_file_path = os.path.join(location, "op.cfg")
    call(["aws", "s3", "cp", "s3://{bucket}/{remote_file}".format(bucket=os.getenv("OP_CONFIG_BUCKET"), remote_file=remote_file), op_config_file_path])
    if not os.path.isfile(op_config_file_path):
        with open(op_config_file_path, 'w') as op_config_file:
            op_config_file.write('[op]\n')

if __name__ == "__main__":
    run(sys.argv[1])
