WITH hourly AS (
    SELECT
        account_id,
        DATE_TRUNC('hour', created_at)        AS tx_hour,
        COUNT(*)                              AS tx_count,
        SUM(amount)                           AS hour_total
    FROM {{ ref('stg_account_transactions') }}
    GROUP BY 1, 2
)
SELECT
    account_id,
    tx_hour,
    tx_count,
    hour_total,
    CASE
        WHEN tx_count > 10      THEN 'VELOCITY_BREACH'
        WHEN hour_total > 50000 THEN 'HIGH_VALUE'
        ELSE 'NORMAL'
    END                                       AS risk_flag
FROM hourly
WHERE tx_count > 10 OR hour_total > 50000
