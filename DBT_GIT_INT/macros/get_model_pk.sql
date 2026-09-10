{% macro get_model_pk(default_key=['ID']) %}
    {% set pks = [] %}
    {% if model and model.meta and model.meta.primary_key %}
        {% set pks = model.meta.primary_key %}
    {% endif %}
    
    {{ return(pks if (pks is list and pks | length > 0) else default_key) }}
{% endmacro %}