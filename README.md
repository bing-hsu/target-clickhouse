# target-clickhouse

target-clickhouse uses the "stream" field of RECORD message to decide into what table the RECORD message are inserted into. 
Configuration document should provide a mapping between stream name and destination table.

target-clickhouse processes and accumulates RECORD message of a stream into a CSV file
and relies
on [HTTP interface](https://stackoverflow.com/questions/52002023/how-to-insert-data-to-clickhouse-from-file-by-http-interface)
to perform build load.


## Target Configuration Document

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
