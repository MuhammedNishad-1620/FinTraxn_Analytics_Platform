SELECT
    CUSTOMER_ID                           AS customer_id,
    NATIONAL_ID                           AS national_id,
    TO_DATE(BIRTH_DATE)                   AS birth_date,
    DATEDIFF('year', TO_DATE(BIRTH_DATE),
             CURRENT_DATE())              AS age,
    CITY                                  AS city,
    STATE                                 AS state
FROM {{ source('raw', 'CUSTOMER_PROFILES') }}
