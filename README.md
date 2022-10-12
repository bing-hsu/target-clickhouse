# target-clickhouse

### Quick Start

1. Create a python virtual environment
2. install target-clickhouse, `pip install yw-etl-target-clickhouse`
3. pipe data to target

```shell
$ <some-tap> | <venv-bin>/target-clickhouse -c '<config-json>' 
```

### Response to Different Types of Message

Only `RECORD` message is processed.

target-clickhouse uses the "stream" field of `RECORD` message to decide into what table the data is inserted into.
Configuration document should provide a mapping,`sync.stream_table_map`, between stream name and destination table.

target-clickhouse processes and accumulates `RECORD` message of a stream into a CSV file
and relies
on [HTTP interface](https://stackoverflow.com/questions/52002023/how-to-insert-data-to-clickhouse-from-file-by-http-interface)
to perform build load.


### Target Configuration Document

```json5
{
  // mandatory
  "connection": {
    "host": "...",
    "port": "...",
    "username": "...",
    "password": "..."
  },
  // mandatory
  "sync.stream_table_map": {
    "<stream-name>": "<database>.<table-name>",
  },
  // optional
  // working directory precedence:
  // 1. conf["sync.working_directory"]
  // 2. env["TARGET_CLICKHOUSE_HOME"]
  // 3. $HOME/.target-clickhouse
  // path is relative to $PWD
  "sync.working_directory": "...",
  // optional
  // default to false
  "sync.retain_csv": false
}
```
