WITH

SOURCE AS (

    SELECT * FROM {{ source('ecom', 'raw_stores') }}

),

RENAMED AS (

    SELECT

        ----------  ids
        ID AS LOCATION_ID,

        ---------- text
        NAME AS LOCATION_NAME,






        ---------- numerics
        TAX_RATE,

        ---------- timestamps
        -- Substituição manual do dbt.date_trunc
        {{ dbt.date_trunc('day', 'opened_at') }} as opened_date

    FROM SOURCE

)

SELECT * FROM RENAMED
