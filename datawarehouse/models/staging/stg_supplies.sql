WITH

source AS (

    SELECT * FROM {{ source('ecom', 'raw_supplies') }}

),

renamed AS (

    SELECT

        ----------  ids
        {{ dbt_utils.generate_surrogate_key(['id', 'sku']) }} AS supply_uuid,
        id AS supply_id,
        sku AS product_id,
        name AS supply_name,

        ---------- text
        perishable AS is_perishable_supply,

        ---------- numerics
        {{ cents_to_dollars('cost') }} AS supply_cost

    FROM source

)

SELECT * FROM renamed
