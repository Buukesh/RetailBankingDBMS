-- -- Advanced Query 1 (Top 5 Customers with Highest Employee Pay Rates)
-- SELECT customer_id, first_name, last_name, employee_level, pay_per_hour
-- FROM (
--     SELECT c.customer_id, c.first_name, c.last_name, ei.employee_level, ep.pay_per_hour
--     FROM CUSTOMERS c
--     JOIN EMPLOYEE_INFO ei ON c.customer_id = ei.customer_id
--     JOIN EMPLOYEE_PAY ep ON ei.employee_level = ep.employee_level
--     ORDER BY ep.pay_per_hour DESC
-- )
-- WHERE ROWNUM <= 5;
--
-- -- Advanced Query 2 (Top 3 Customers’ Highest Total Account Balances)
-- SELECT customer_id, first_name, last_name, total_balance
-- FROM (
--     SELECT c.customer_id, c.first_name, c.last_name, SUM(a.balance) AS total_balance
--     FROM CUSTOMERS c
--     JOIN ACCOUNTS a ON c.customer_id = a.customer_id
--     GROUP BY c.customer_id, c.first_name, c.last_name
--     ORDER BY total_balance DESC
-- )
-- WHERE ROWNUM <= 3;
--
-- -- Advanced Query 3 (Transactions by Descending Amount with Customer Names)
-- SELECT t.transaction_id, c.first_name, c.last_name, t.other_party, t.amount
-- FROM CUSTOMERS c
-- JOIN ACCOUNTS a ON c.customer_id = a.customer_id
-- JOIN TRANSACTIONS t ON a.account_id = t.account_id
-- GROUP BY c.first_name, c.last_name, t.transaction_id, t.other_party, t.amount
-- ORDER BY t.amount DESC;
-- Basic Queries
SELECT DISTINCT country FROM CUSTOMER_ADDRESS ORDER BY country ASC
--
SELECT DISTINCT country, province_state, city, COUNT(*) AS customer_count FROM CUSTOMER_ADDRESS WHERE country = 'USA' GROUP BY country, province_state, city ORDER BY country DESC, province_state DESC, city DESC
--
SELECT DISTINCT first_name,last_name, email FROM CUSTOMERS ORDER BY first_name ASC, last_name ASC
--
SELECT DISTINCT employee_level, pay_per_hour FROM EMPLOYEE_PAY WHERE pay_per_hour BETWEEN 15.50 AND 21.50 ORDER BY employee_level DESC
--
SELECT DISTINCT type, SUM(amount) AS total_amount FROM TRANSACTIONS GROUP BY type ORDER BY total_amount ASC
--
SELECT account_id, balance, currency FROM ACCOUNTS WHERE status <> 0 GROUP BY account_id, balance, currency ORDER BY balance DESC
SELECT DISTINCT value, description FROM KYC ORDER BY value DESC
SELECT category, COUNT(product_id) AS product_count FROM ACCOUNT_STRUCT GROUP BY category ORDER BY product_count DESC