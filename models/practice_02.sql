{{ config(materialized='view') }}

{{ dynamic_source_table('gentle-charmer-297601.test.raw') }}
union all (
    {{ dynamic_source_table('gentle-charmer-297601.test.raw_02') }}
)