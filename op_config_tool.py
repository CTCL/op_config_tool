#!/usr/bin/env python
"""
simple script to get a value out of a provided config file
"""
from ConfigParser import ConfigParser
from argparse import ArgumentParser
import sys, os
OP_CONFIG_DIR = os.path.dirname(os.path.abspath(__file__))
DEFAULT_OP_CONFIG_FILE = os.path.join(OP_CONFIG_DIR, 'op.cfg')
def get(entry, section='op', op_config_file=DEFAULT_OP_CONFIG_FILE):
    """
    parse the provided op config value out of the provided op config file
    """
    op_config = ConfigParser()
    op_config.read([op_config_file])
    if op_config.has_section(section):
        if entry in op_config.options(section):
            return op_config.get(section, entry)
        else:
            raise ValueError('section {section} has no entry {entry}'
                             .format(section=section, entry=entry))
    else:
        raise ValueError('op config file {op_config_file} has no section \
                {section}'.format(op_config_file=op_config_file,
                                  section=section))

if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('op_config_file')
    parser.add_argument('section', nargs='?', default='op')
    parser.add_argument('entry')
    arguments = parser.parse_args(sys.argv[1:])
    print get(**arguments.__dict__)
