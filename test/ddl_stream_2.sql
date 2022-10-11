create table if not exists test_target_ck.stream_2
(
    a int,
    b text,
    c text
) engine = MergeTree ORDER BY a
