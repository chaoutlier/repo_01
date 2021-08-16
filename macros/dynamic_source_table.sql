{% macro dynamic_source_table (tableID) %}
    select *
    from {{ tableID }}
{% endmacro %}