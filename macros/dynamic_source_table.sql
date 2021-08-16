{% macro dynamic_source_table (tableID) %}
    select *
    from  `gentle-charmer-297601.test.{{ tableID }}`
{% endmacro %}