SELECT
    ACCOUNT_ID                            AS account_id,
    CUSTOMER_ID                           AS customer_id,
    ACCOUNT_TYPE                          AS account_type,
    TO_DATE(CREATION_DATE)                AS creation_date,
    ACCOUNT_STATUS                        AS account_status,
    ROUND(BALANCE::FLOAT, 2)               AS balance,
    ROUND(LOAN_AMOUNT::FLOAT, 2)           AS loan_amount,
    TERM_MONTHS::INT                      AS term_months,
    INTEREST_RATE::FLOAT                  AS interest_rate
FROM {{ source('raw', 'BANK_ACCOUNTS') }}
