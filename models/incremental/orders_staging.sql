{{
    config(
        materialized = 'table'
    )
}}

WITH

extract_date AS (

    SELECT
        id,
        customer,
        CAST(ordered_at AS DATE) AS order_date,
        subtotal,
        tax_paid,
        order_total

    FROM {{ ref('raw_orders') }}

)

SELECT *

FROM extract_date
