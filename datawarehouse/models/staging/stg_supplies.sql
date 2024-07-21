with

source as (

    select * from {{ source('ecom', 'raw_supplies') }}

),

renamed as (

    select

        ----------  ids
        {{ dbt_utils.generate_surrogate_key(['id', 'sku']) }} as supply_uuid,
        id as supply_id,
        sku as product_id,
        name as supply_name,

        ---------- text
        perishable as is_perishable_supply,

        ---------- numerics
        {{ cents_to_dollars('cost') }} as supply_cost

    from source

)

select * from renamed
