#!/usr/bin/env python
import sys, os
from argparse import ArgumentParser
from subprocess import call
def run(remote_file, op_config_bucket, local_file):
    location = os.path.dirname(os.path.abspath(__file__))
    op_config_file_path = os.path.join(location, local_file)
    call(["aws", "s3", "cp", "s3://{bucket}/{remote_file}".format(
        bucket=op_config_bucket, remote_file=remote_file), op_config_file_path])
    if not os.path.isfile(op_config_file_path):
        sys.stderr.write(
            'could not download op config {remote_file} from {bucket}'.format(
                remote_file=remote_file, bucket=op_config_bucket))

if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument('remote_file', nargs='?',
                        default=os.getenv("OP_CONFIG_FILE", "op.cfg"))
    parser.add_argument('op_config_bucket', nargs='?',
                        default=os.getenv("OP_CONFIG_BUCKET"))
    parser.add_argument('local_file', nargs='?', default='op.cfg')
    arguments = parser.parse_args(sys.argv[1:])
    run(**arguments.__dict__)
