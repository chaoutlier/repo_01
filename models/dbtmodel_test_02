{{ config(
    materialized="view",
    schema="marketing"
) }}

select *
from {{ ref('dbtmodel_test_01') }}