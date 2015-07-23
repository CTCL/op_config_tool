# Operation Configuration setup tool
This tool will grab a file called op.cfg from an s3 bucket specified in the environment variable OP_CONFIG_BUCKET and place it in the home directory of the repo. 
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
to get a config entry from the specified section or from default section "op" of the op config file.
it also makes the op_config_tool module available on the python path so that op config entries can be accessed within python like
```python
import op_config_tool
op_config_tool.get(<entry>, <section>, <op config file>)
op_config_tool.get(<entry>, <section>)
op_config_tool.get(<entry>)
```
which will assume default section of "op" if it is omitted and default file of op.cfg if it is omitted
