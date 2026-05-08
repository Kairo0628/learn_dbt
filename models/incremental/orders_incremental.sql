{{
    config(
        materialized = 'incremental',
        unique_key = 'id',
        incremental_predicates = ['DBT_INTERNAL_DEST.order_date > DATE_ADD(CURRENT_DATE(), INTERVAL -7 DAY)']
    )
}}

SELECT *

FROM {{ ref('orders_staging') }}

{% if is_incremental() %}

WHERE order_date > ( SELECT COALESCE(MAX(order_date), '2016-09-01') FROM {{ this }} )

{% endif %}
