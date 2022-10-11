# target-clickhouse

target-clickhouse uses the "stream" field of RECORD message to decide into what table the RECORD message are inserted into. 
Configuration document should provide a mapping between stream name and destination table.

target-clickhouse processes and accumulates RECORD message of a stream into a CSV file
and relies
on [inserting data from a file](https://clickhouse.com/docs/en/sql-reference/statements/insert-into#inserting-data-from-a-file)
to perform build load.

```sql
INSERT INTO {database}.{table}
FROM INFILE {file_name} FORMAT CSV
```

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
