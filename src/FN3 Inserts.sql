-- Insert data into KYC table
INSERT INTO KYC (value, description) VALUES (0, 'Clear')
INSERT INTO KYC (value, description) VALUES (1, 'Flagged')
INSERT INTO KYC (value, description) VALUES (2, 'Warned')
INSERT INTO KYC (value, description) VALUES (3, 'Suspended')
INSERT INTO KYC (value, description) VALUES (4, 'Black Listed')
-- -- Insert data into EMPLOYEE_PAY table
INSERT INTO EMPLOYEE_PAY (employee_level, pay_per_hour) VALUES (1, 15.50)
INSERT INTO EMPLOYEE_PAY (employee_level, pay_per_hour) VALUES (2, 18.00)
INSERT INTO EMPLOYEE_PAY (employee_level, pay_per_hour) VALUES (3, 20.25)
INSERT INTO EMPLOYEE_PAY (employee_level, pay_per_hour) VALUES (4, 22.75)
INSERT INTO EMPLOYEE_PAY (employee_level, pay_per_hour) VALUES (5, 25.00)
--
-- -- Insert data into CUSTOMERS table
INSERT INTO CUSTOMERS (customer_id, first_name, last_name, phone, email, kyc_flag, address_id) VALUES ('CUST0001', 'Jane', 'Smith', '9876543210', 'jane.smith@example.com', 2, 'ADDR0001')
INSERT INTO CUSTOMERS (customer_id, first_name, last_name, phone, email, kyc_flag, address_id) VALUES ('CUST0002', 'Michael', 'Johnson', '5551234567', 'michael.johnson@example.com', 0, 'ADDR0002')
INSERT INTO CUSTOMERS (customer_id, first_name, last_name, phone, email, kyc_flag, address_id) VALUES ('CUST0003', 'Emily', 'Wilson', '1112223333', 'emily.wilson@example.com', 3, 'ADDR0003')
INSERT INTO CUSTOMERS (customer_id, first_name, last_name, phone, email, kyc_flag, address_id) VALUES ('CUST0004', 'Robert', 'Anderson', '9998887777', 'robert.anderson@example.com', 4, 'ADDR0004')
INSERT INTO CUSTOMERS (customer_id, first_name, last_name, phone, email, kyc_flag, address_id) VALUES ('CUST0005', 'Olivia', 'Davis', '3334445555', 'olivia.davis@example.com', 2, 'ADDR0005')
--
-- -- Insert more data into CUSTOMER_ADDRESS table
INSERT INTO CUSTOMER_ADDRESS (address_id, customer_id, street_number, street_name, postal_code, country, province_state, city) VALUES ('ADDR0001', 'CUST0001', 456, 'Maple Avenue', '54321', 'USA', 'NY', 'New York')
INSERT INTO CUSTOMER_ADDRESS (address_id, customer_id, street_number, street_name, postal_code, country, province_state, city) VALUES ('ADDR0002', 'CUST0002', 789, 'Oak Street', '67890', 'USA', 'TX', 'Houston')
INSERT INTO CUSTOMER_ADDRESS (address_id, customer_id, street_number, street_name, postal_code, country, province_state, city) VALUES ('ADDR0003', 'CUST0003', 789, 'Cedar Lane', '54321', 'USA', 'CA', 'San Francisco')
INSERT INTO CUSTOMER_ADDRESS (address_id, customer_id, street_number, street_name, postal_code, country, province_state, city) VALUES ('ADDR0004', 'CUST0004', 456, 'Pine Street', '67890', 'USA', 'TX', 'Austin')
INSERT INTO CUSTOMER_ADDRESS (address_id, customer_id, street_number, street_name, postal_code, country, province_state, city) VALUES ('ADDR0005', 'CUST0005', 123, 'Elm Avenue', '98765', 'USA', 'NY', 'Albany')
--
--
-- -- Insert data into ACCOUNT_STRUCT table
INSERT INTO ACCOUNT_STRUCT (product_id, name, category, structure) VALUES ('PROD0001', 'Savings Account', 'Savings', 'xx2')
INSERT INTO ACCOUNT_STRUCT (product_id, name, category, structure) VALUES ('PROD0002', 'Chequing Account', 'Chequing', 'xx1')
INSERT INTO ACCOUNT_STRUCT (product_id, name, category, structure) VALUES ('PROD0003', 'Investment Account', 'Investing', 'xx5')
--
-- -- Insert data into ACCOUNTS table
INSERT INTO ACCOUNTS (account_id, product_id, customer_id, balance, currency, status) VALUES ('ACCT0001', 'PROD0001', 'CUST0001', 1000.00, 'USD', 1)
INSERT INTO ACCOUNTS (account_id, product_id, customer_id, balance, currency, status) VALUES ('ACCT0002', 'PROD0002', 'CUST0001', 2500.00, 'EUR', 1)
INSERT INTO ACCOUNTS (account_id, product_id, customer_id, balance, currency, status) VALUES ('ACCT0003', 'PROD0003', 'CUST0002', 1500.00, 'GBP', 1)
INSERT INTO ACCOUNTS (account_id, product_id, customer_id, balance, currency, status) VALUES ('ACCT0004', 'PROD0001', 'CUST0003', 3000.00, 'USD', 0)
INSERT INTO ACCOUNTS (account_id, product_id, customer_id, balance, currency, status) VALUES ('ACCT0005', 'PROD0002', 'CUST0004', 500.00, 'EUR', 1)
INSERT INTO ACCOUNTS (account_id, product_id, customer_id, balance, currency, status) VALUES ('ACCT0006', 'PROD0003', 'CUST0001', 2000.00, 'GBP', 1)
--
-- -- Insert data into TRANSACTIONS table
INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0001', 'ACCT0001', 'Deposit', 500.00, 'Self')
INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0002', 'ACCT0001', 'Withdrawal', 200.00, 'ATM')
-- INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0003', 'ACCT0001', 'Transfer', 100.00, 'ACCT0002')
INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0004', 'ACCT0001', 'Deposit', 300.00, 'Self')
INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0005', 'ACCT0001', 'Withdrawal', 50.00, 'Self')
INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0006', 'ACCT0001', 'Withdrawal', 75.00, 'ATM')
INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0007', 'ACCT0002', 'Deposit', 1000.00, 'Self')
INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0008', 'ACCT0002', 'Withdrawal', 150.00, 'ATM')
INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0009', 'ACCT0002', 'Deposit', 200.00, 'ATM')
INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0010', 'ACCT0002', 'Deposit', 500.00, 'Self')
INSERT INTO TRANSACTIONS (transaction_id, account_id, type, amount, other_party) VALUES ('TRANS0011', 'ACCT0002', 'Withdrawal', 75.00, 'ATM')
--
-- -- Insert data into EMPLOYEE_INFO table
INSERT INTO EMPLOYEE_INFO (employee_id, employee_level, customer_id) VALUES ('EMPL0001', 3, 'CUST0001')
INSERT INTO EMPLOYEE_INFO (employee_id, employee_level, customer_id) VALUES ('EMPL0002', 4, 'CUST0002')
INSERT INTO EMPLOYEE_INFO (employee_id, employee_level, customer_id) VALUES ('EMPL0003', 5, 'CUST0003')
