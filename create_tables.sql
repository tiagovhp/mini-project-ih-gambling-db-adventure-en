USE ibeting;

CREATE TABLE IF NOT EXISTS account (
	id INT NOT NULL AUTO_INCREMENT,
    account_no VARCHAR(10) NOT NULL,
    cust_id VARCHAR(10) NOT NULL,
    account_loc CHAR(3) NOT NULL,
    currency CHAR(3) NOT NULL,
    deposit_limit_day DECIMAL (10,2) NOT NULL DEFAULT 0,
    skatescale DECIMAL(5,2) NOT NULL DEFAULT 0,
    source_prod VARCHAR(10) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE(account_no)
    );

CREATE TABLE IF NOT EXISTS betting(
	id INT NOT NULL AUTO_INCREMENT,
    account_no VARCHAR(10) NOT NULL,
    bet_date DATE,
    class_id VARCHAR(15) NOT NULL,
    category_id INT NOT NULL,
    `source` CHAR(1) NOT NULL,
    bet_count INT NOT NULL,
    bet_amt DECIMAL(15,4),
    win_amt DECIMAL(15,4),
    product VARCHAR(15),
    PRIMARY KEY (id)
    );
    
CREATE TABLE IF NOT EXISTS customer(
	id INT NOT NULL AUTO_INCREMENT,
    cust_id INT NOT NULL,
    account_loc VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    create_date VARCHAR(255) NOT NULL,
    country_code VARCHAR(255) NOT NULL,
    `language` VARCHAR(255) NOT NULL,
    `status` VARCHAR(255) NOT NULL,
    date_of_birth VARCHAR(255) NOT NULL,
    contact VARCHAR(255) NOT NULL,
    customer_group VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS product(
	id INT NOT NULL AUTO_INCREMENT,
    class_id VARCHAR(255),
    category_id INT NOT NULL,
    product VARCHAR(255) NOT NULL,
    subproduct VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    bet_or_play INT,
    PRIMARY KEY (id)
);
    
SELECT * FROM account;
    