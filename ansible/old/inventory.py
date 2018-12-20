#!/usr/bin/env python
import os
import argparse
import json
from python_terraform import *

parser = argparse.ArgumentParser(description='Generate inventory.json')
parser.add_argument('--list', action='store_true', help='Return all hosts')
parser.add_argument('--host')

args = parser.parse_args()

if 'ENV' not in os.environ:
    raise Exception('ENV variable in environment required')

env = os.environ['ENV']

CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
WORKING_DIR = os.path.abspath(os.path.join(CURRENT_DIR, '../terraform', env))

if not os.path.isdir(WORKING_DIR):
    raise Exception('Path `%s` not found' % (WORKING_DIR,))

tf = Terraform(working_dir=WORKING_DIR)
vars = tf.output()

output = {
    'appserver': {
        'hosts': [vars['app_external_ip']['value']]
    },
    'dbserver': {
        'hosts': [vars['db_external_ip']['value']]
    },
    '_meta': {
        'hostvars': {}
    }
}

if args.host:
    if args.host not in output:
        raise Exception('Host `%s` not found' % (args.host,))
    
    print(json.dumps(output[args.host]))
else:
    print(json.dumps(output))
