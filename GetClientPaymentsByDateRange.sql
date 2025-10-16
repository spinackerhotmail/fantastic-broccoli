CREATE OR REPLACE FUNCTION get_client_payments_by_date_range(
    p_client_id BIGINT,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS TABLE (
    dt DATE,
    suma NUMERIC
)
LANGUAGE SQL
AS $$
    WITH date_range AS (
        -- Генерируем последовательность дат от начальной до конечной даты
        SELECT generate_series(p_start_date, p_end_date, '1 day'::interval)::date AS dt
    ),
    payment_sums AS (
        -- Группируем платежи по дате и клиенту, суммируя amount
        SELECT 
            dt::date AS payment_date,
            SUM(amount) AS total_amount
        FROM client_payments
        WHERE client_id = p_client_id
            AND dt::date BETWEEN p_start_date AND p_end_date
        GROUP BY dt::date
    )
    -- Объединяем 
    SELECT 
        dr.dt,
        COALESCE(ps.total_amount, 0) AS suma
    FROM date_range dr
    LEFT JOIN payment_sums ps ON dr.dt = ps.payment_date
    ORDER BY dr.dt;
$$;
