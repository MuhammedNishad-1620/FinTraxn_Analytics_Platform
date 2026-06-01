SELECT
    cp.customer_id,
    cp.state,
    cp.city,
    cp.age,
    FLOOR(cp.age / 10) * 10                       AS age_band,
    COUNT(DISTINCT ba.account_id)                 AS total_accounts,
    COUNT(DISTINCT ba.account_type)               AS product_count,
    SUM(ba.balance)                               AS total_balance,
    SUM(ba.loan_amount)                           AS total_loan,
    MAX(CASE WHEN ba.account_status = 'Inactive'
             THEN 1 ELSE 0 END)                   AS has_inactive_account,
    COUNT(tx.transaction_id)                      AS lifetime_tx_count,
    SUM(CASE WHEN tx.transaction_type='Debit'
             THEN tx.amount ELSE 0 END)           AS total_spend,
    MAX(tx.created_at)                            AS last_transaction_date
FROM {{ ref('stg_customer_profiles') }} cp
JOIN {{ ref('stg_bank_accounts') }}     ba
  ON ba.customer_id = cp.customer_id
LEFT JOIN {{ ref('stg_account_transactions') }} tx
  ON tx.account_id = ba.account_id
GROUP BY 1,2,3,4,5
