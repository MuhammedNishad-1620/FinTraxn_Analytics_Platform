SELECT
    TRANSACTION_ID                        AS transaction_id,
    ACCOUNT_ID                            AS account_id,
    TO_TIMESTAMP(CREATED_TIME)            AS created_at,
    UPPER(TRANSACTION_TYPE)               AS transaction_type,
    TRANSACTION_CODE                      AS transaction_code,
    ROUND(AMOUNT::FLOAT, 2)               AS amount,
    CHANNEL                               AS channel
FROM {{ source('raw', 'ACCOUNT_TRANSACTIONS') }}
WHERE AMOUNT > 0
  AND TRANSACTION_ID IS NOT NULL
