{% set table_list = ["raw", "raw_02"] %}

{% for table in table_list %}

  {{ dynamic_source_table(table) }}
    {% if not loop.last %}
        union all
    {% endif %}

{% endfor %}