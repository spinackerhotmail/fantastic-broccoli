CREATE TABLE IF NOT EXISTS client_payments
(
    id BIGSERIAL PRIMARY KEY,
    client_id BIGINT NOT NULL,
    dt TIMESTAMP(0) NOT NULL,
    amount NUMERIC(19,4) NOT NULL
);

INSERT INTO client_payments (client_id, dt, amount) VALUES
(1, '2022-01-03 17:24:00', 100),
(1, '2022-01-05 17:24:14', 200),
(1, '2022-01-05 18:23:34', 250),
(1, '2022-01-07 10:12:38', 50),
(2, '2022-01-05 17:24:14', 278),
(2, '2022-01-10 12:39:29', 300);

-- Тестирование функции
SELECT 'Test 1 - ClientId 1' AS test_name;
SELECT * FROM get_client_payments_by_date_range(1, '2022-01-02', '2022-01-07');

SELECT 'Test 2 - ClientId 2' AS test_name;
SELECT * FROM get_client_payments_by_date_range(2, '2022-01-04', '2022-01-11');
