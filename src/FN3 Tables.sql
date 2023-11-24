-- -- Create KYC table
CREATE TABLE KYC (value NUMBER PRIMARY KEY CHECK (value BETWEEN 0 AND 4), description VARCHAR2(20))
-- Create EMPLOYEE_PAY table
CREATE TABLE EMPLOYEE_PAY (employee_level NUMBER PRIMARY KEY CHECK (employee_level BETWEEN 1 AND 5), pay_per_hour FLOAT UNIQUE CHECK (pay_per_hour > 0))
--
-- Create CUSTOMERS table
CREATE TABLE CUSTOMERS (customer_id VARCHAR2(100) PRIMARY KEY CHECK (REGEXP_LIKE(customer_id, '^CUST[0-9]+')), first_name VARCHAR2(100), last_name VARCHAR2(100), phone VARCHAR2(20) CHECK (REGEXP_LIKE(phone, '^[0-9]{10}$')), email VARCHAR2(100) CHECK (REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$')), kyc_flag NUMBER CHECK (kyc_flag BETWEEN 0 AND 4))
--
-- Create CUSTOMER_ADDRESS table
CREATE TABLE CUSTOMER_ADDRESS (address_id VARCHAR2(100) PRIMARY KEY CHECK (REGEXP_LIKE(address_id, '^ADDR[0-9]+')), customer_id VARCHAR2(100), street_number NUMBER, street_name VARCHAR2(100), postal_code VARCHAR2(10), country VARCHAR2(80), province_state VARCHAR2(20), city VARCHAR2(100), CONSTRAINT fk_customer_address FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id))
--
-- Create ACCOUNT_STRUCT table
CREATE TABLE ACCOUNT_STRUCT (product_id VARCHAR2(100) PRIMARY KEY CHECK (REGEXP_LIKE(product_id, '^PROD[0-9]+')), name VARCHAR2(100), category VARCHAR2(100), structure VARCHAR2(3))
--
-- Create ACCOUNTS table
CREATE TABLE ACCOUNTS (account_id VARCHAR2(100) PRIMARY KEY CHECK (REGEXP_LIKE(account_id, '^ACCT[0-9]+')), product_id VARCHAR2(100), customer_id VARCHAR2(100), balance FLOAT, currency VARCHAR2(4), status NUMBER(1) CHECK (status IN (0, 1)), CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES ACCOUNT_STRUCT(product_id), CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id))
--
-- Create TRANSACTIONS table with additional constraints
CREATE TABLE TRANSACTIONS (transaction_id VARCHAR2(100) PRIMARY KEY CHECK (REGEXP_LIKE(transaction_id, '^TRANS[0-9]+')), account_id VARCHAR2(100), type VARCHAR2(10) CHECK (type IN ('Transfer', 'Withdrawal', 'Deposit')), amount FLOAT CHECK (amount > 0), other_party VARCHAR2(100) CHECK (other_party IN ('Self', 'ATM')), CONSTRAINT fk_account FOREIGN KEY (account_id) REFERENCES ACCOUNTS(account_id))
--
-- Create EMPLOYEE_INFO table
CREATE TABLE EMPLOYEE_INFO (employee_id VARCHAR2(100) PRIMARY KEY CHECK (REGEXP_LIKE(employee_id, '^EMPL[0-9]+')), employee_level NUMBER CHECK (employee_level BETWEEN 1 AND 5), customer_id VARCHAR2(100), CONSTRAINT fk_customer_info FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id), CONSTRAINT fk_level_info UNIQUE (customer_id, employee_level), CONSTRAINT chk_unique_employee_level UNIQUE (employee_level))
