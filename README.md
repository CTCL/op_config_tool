# Operation Configuration setup tool
This tool will grab a file specified in environment variable OP_CONFIG_FILE or op.cfg by default from an s3 bucket specified in the environment variable OP_CONFIG_BUCKET and place it in the home directory of the repo. Whatever credentials the aws client will decide to use by default must have access to the specified bucket. This can be achieved, for example, by running this on an EC2 instance whose role has access to the bucket, or in a container on that instance. 
Running 
```sh
source setup.sh
```
creates an alias "opc" that can be called as follows:
```sh
opc <config section> <section entry>
```
or
```sh
opc <section entry>
```
running fetch.sh or the run function in fetch_op_config.py will download the specified op config file from s3.

to get a config entry from the specified section or from default section "op" of the op config file.
it also makes the op_config_tool module available on the python path so that op config entries can be accessed within python like
```python
import op_config_tool
op_config_tool.get(<entry>, <section>, <op config file>)
op_config_tool.get(<entry>, <section>)
op_config_tool.get(<entry>)
```
which will assume default section of "op" if it is omitted and default file of op.cfg if it is omitted

Files have the basic format
```
[op]
AWS_REGION=us-west-2
[db]
DB_HOST=blah.blah.blah
DB_PORT=5432
```
