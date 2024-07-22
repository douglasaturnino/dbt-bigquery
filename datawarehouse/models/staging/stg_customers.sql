WITH

source AS (

    SELECT * FROM {{ source('ecom', 'raw_customers') }}

),

renamed AS (

    SELECT

        ----------  ids
        id AS customer_id,
        name AS customer_name

    FROM source

)

SELECT * FROM renamed
