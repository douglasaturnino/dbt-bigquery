WITH

source AS (

-- Usando a macro dbt_utils.union_relations para combinar as tabelas raw_orders_2016 e raw_orders_2017
    {{ dbt_utils.union_relations(
        relations=[
            source('ecom', 'raw_orders_2023'),
            source('ecom', 'raw_orders_2024')
        ]
    ) }}

),

renamed AS (

    SELECT

        ----------  ids
        id AS order_id,
        store_id AS location_id,
        customer AS customer_id,

        ---------- numerics
        subtotal AS subtotal_cents,
        tax_paid AS tax_paid_cents,
        order_total AS order_total_cents,
        {{ cents_to_dollars('subtotal') }} AS subtotal,
        {{ cents_to_dollars('tax_paid') }} AS tax_paid,
        {{ cents_to_dollars('order_total') }} AS order_total,

        ---------- timestamps
        {{ dbt.date_trunc('day','ordered_at') }} AS ordered_at

    FROM source

)

SELECT * FROM renamed
