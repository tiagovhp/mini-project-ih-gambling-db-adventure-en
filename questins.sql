-- Mini Project | The Ironhack Gambling Database Adventure
USE ibeting;

-- **Question 01**:  Using the customer table or tab, please write an SQL query that shows Title, First Name and Last Name and Date of Birth for each of the customers.
SELECT
	title,
    fname,
    lname,
    date_of_birth
FROM customer;

-- **Question 02**:  Using customer table or tab, please write an SQL query that shows the number of customers in each customer group (Bronze, Silver & Gold). I can see visually that there are 4 Bronze, 3 Silver and 3 Gold but if there were a million customers how would I do this in Excel?
SELECT
	customer_group,
    COUNT(id)
FROM customer
GROUP BY customer_group;

-- **Question 03**: The CRM manager has asked me to provide a complete list of all data for those customers in the customer table but I need to add the currencycode of each player so she will be able to send the right offer in the right currency. Note that the currencycode does not exist in the customer table but in the account table. Please write the SQL that would facilitate this.
SELECT 
	*,
    account.currency
FROM 
	customer
INNER JOIN 
	account
ON
	account.cust_id = customer.cust_id;
    
-- **Question 04**: Now I need to provide a product manager with a summary report that shows, by product and by day how much money has been bet on a particular product. PLEASE note that the transactions are stored in the betting table and there is a product code in that table  that is required to be looked up (classid & categortyid) to determine which product family this belongs to. Please write the SQL that would provide the report. 
SELECT
	product,
    bet_date,
    SUM(bet_amt) AS 'amount_day_product',
    SUM(bet_count) as 'bets_day_product'
FROM
	betting
GROUP BY product, bet_date
ORDER BY bet_date ASC;

-- **Question 05**: You’ve just provided the report from question 4 to the product manager, now he has emailed me and wants it changed. Can you please amend the summary report so that it only summarizes transactions that occurred on or after 1st November and he only wants to see Sportsbook transactions.Again, please write the SQL below that will do this. 
SELECT
	product,
    bet_date,
    SUM(bet_amt) AS 'amount_day_product',
    SUM(bet_count) as 'bets_day_product'
FROM
	betting
WHERE bet_date >= '2012-11-01'
GROUP BY product, bet_date
ORDER BY bet_date ASC;

-- **Question 06**: As often happens, the product manager has shown his new report to his director and now he also wants different version of this report. This time, he wants the all of the products but split by the currencycode and customergroup of the customer, rather than by day and product. He would also only like transactions that occurred after 1st December. Please write the SQL code that will do this.


-- **Question 07**: Our VIP team have asked to see a report of all players regardless of whether they have done anything in the complete timeframe or not. In our example, it is possible that not all of the players have been active. Please write an SQL query that shows all players Title, First Name and Last Name and a summary of their bet amount for the complete period of November.
SELECT
	customer.cust_id,
    customer.title,
	customer.fname,
	customer.lname,
    account.account_no,
    SUM(bet_count) AS 'nr_of_bets',
    SUM(bet_amt)
FROM 
	customer
LEFT JOIN
	account
ON
	customer.cust_id=account.cust_id
LEFT JOIN
	betting
ON
	account.account_no = betting.account_no
WHERE 
	bet_date >= '2012-11-01' AND bet_date <= '2012-11-30'
OR
	bet_amt = 0
GROUP BY customer.cust_id,
    customer.title,
	customer.fname,
	customer.lname,
    account.account_no;

-- **Question 08**: Our marketing and CRM teams want to measure the number of players who play more than one product. Can you please write 2 queries, one that shows the number of products per player and another that shows players who play both Sportsbook and Vegas.	

-- PRODUCT PER PLAYER OF THOSE WHO PLAY MORE THAN 1 PRODUCT
SELECT 
	account.cust_id,
	betting.account_no,
    COUNT(betting.id) AS bets_player,
    COUNT(DISTINCT betting.product) AS products_player
FROM
	betting
JOIN
	account
ON
	account.account_no = betting.account_no
GROUP BY 
	betting.account_no,
    account.cust_id
HAVING
	products_player > 1;

--  PLAYERS WHO PLAY SPORTSBOOK AND VEGAS
SELECT
	account.cust_id,
	betting.account_no,
    COUNT(betting.id) as nr_bets,
    COUNT(DISTINCT betting.product) AS vegas_sport,
    group_concat(DISTINCT betting.product)
FROM
	betting
JOIN
	account
ON
	account.account_no = betting.account_no
WHERE
	product IN ('Vegas', 'Sportsbook')
GROUP BY
	account.account_no,
    account.cust_id
 HAVING
	vegas_sport = 2;
    
-- **Question 09**: Now our CRM team want to look at players who only play one product, please write SQL code that shows the players who only play at sportsbook, use the bet_amt > 0 as the key. Show each player and the sum of their bets for both products. 
## PLAYERS WHO ONLY PLAY ONE PRODUCT "SPORTSBOOK"
SELECT
    account.cust_id,
	betting.account_no,
    COUNT(betting.id) as nr_bets,
    COUNT(DISTINCT betting.product) AS products_player,
    SUM(betting.bet_amt)
FROM
	betting
JOIN
	account
ON
	account.account_no = betting.account_no
GROUP BY
	account.account_no,
    account.cust_id,
    betting.product
HAVING
	products_player = 1
	AND betting.product = 'Sportsbook';

-- **Question 10**: The last question requires us to calculate and determine a player’s favorite product. This can be determined by the most money staked. Please write a query that will show each players favorite product.
SELECT
    cust_id,
    player_product_amount.product,
    MAX(amount_won_per_product)
FROM
    (SELECT
		account.cust_id,
		-- account.account_no,
		-- betting.id,
		betting.product,
		SUM(betting.win_amt) AS amount_won_per_product
	FROM
		betting
	INNER JOIN
		account
	ON
		account.account_no = betting.account_no
	GROUP BY
		account.cust_id,
		betting.product
	HAVING
		amount_won_per_product > 0) 
	AS player_product_amount
GROUP BY
	player_product_amount.cust_id,
    player_product_amount.product;



