{% macro get_primary_keys(relation) %}
  {% set pk_cols = [] %}
  
  {% if execute and relation %}
    {% set pk_query %}
      show primary keys in table {{ relation }}
    {% endset %}
    
    {% set results = run_query(pk_query) %}
    
    {% if results %}
      {% for row in results %}
        {% do pk_cols.append(row['column_name'] | lower) %}
      {% endfor %}
    {% endif %}
  {% endif %}
  
  {{ return(pk_cols) }}
{% endmacro %}