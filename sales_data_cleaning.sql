/*  1.1 Before analysis cleaning the data is needed.
    Not to damage the original dataset a copy must be created */
  
CREATE TABLE public.sales_altered (
    "index" int4 NULL,
    order_id text NULL,
    "date" date NULL,
    status text NULL,
    fulfilment text NULL,
    sales_channel text NULL,
    ship_service_level text NULL,
    "style" text NULL,
    sku text NULL,
    category text NULL,
    "size" text NULL,
    asin text NULL,
    courier_status text NULL,
    qty int4 NULL,
    currency text NULL,
    amount numeric NULL,
    ship_city text NULL,
    ship_state text NULL,
    ship_postal_code numeric NULL,
    ship_country text NULL,
    promotion_ids text NULL,
    b2b bool NULL,
    fullfilled_by text NULL,
    "unnamed" text NULL
);

--  1.2 To insert the data from our initial table to the new one:

INSERT INTO sales_altered 
SELECT
    *
FROM 
    sales s 
ORDER BY 1


--  2. Removing irrelevant data:
    
--  Show sales in the 3-rd month
    
SELECT
    EXTRACT(MONTH FROM date)    AS month,
    COUNT(order_id)             AS days_per_month
FROM
    sales_altered sa 
GROUP BY 1

/*  2.1 I make decision to delete this month due to lack of data for this month 
    (only 171 orders were made in March) also all of the sales were made in 31-st of March */

DELETE
FROM sales_altered 
WHERE EXTRACT(MONTH FROM date) = 3

--  2.2 Before analyzing we also have to delete column "unnamed" as it doesn't have a lot of information
    
ALTER TABLE sales_altered 
DROP COLUMN unnamed

--  2.3 Before analyzing we also have to delete column "promotion_ids" as it doesn't have a lot of information

ALTER TABLE sales_altered 
DROP COLUMN promotion_ids

--  2.4 Before analyzing we also have to delete rows where the "amount" is NULL

DELETE 
FROM sales_altered 
WHERE amount IS NULL


--  3. Handling missing data:

--  3.1 To fill in all of the nulls in "currency", as all of the sales were made in India:

UPDATE sales_altered 
SET currency = 'INR'
WHERE currency IS NULL

--  3.2 To delete all of the rows where "ship_coutry" is NULL, as it may disturb our analysis:
    
DELETE 
FROM sales_altered 
WHERE INDEX IN (
SELECT
    index
FROM
    sales_altered sa 
WHERE 
    ship_country IS NULL)
    
--  And with that all of the rows with NULL ship_postal_code and ship_city were also deleted

    
--  4. Fixing structural errors:

--  4.1 Change 'kurta' to Proper case
    
UPDATE sales_altered 
SET category = INITCAP(category)
 
--  4.2 Names of the states and cities also are  not standardized
    
--  4.2.1 First of all we have to make them in Proper case:
    
UPDATE sales_altered 
SET ship_city = INITCAP(ship_city)

UPDATE sales_altered 
SET ship_state = INITCAP(ship_state)

--  There are total of 36 states in India, however in our database there are 47 distinct states, which has to be changed

/*  4.2.2 Join this dataset: https://github.com/recurze/IndianCities/blob/master/final_states.csv
    to show which states do not have a proper naming: */

SELECT
    DISTINCT sa.ship_state
FROM
    sales_altered sa 
WHERE 
    ship_state NOT IN (SELECT state FROM states)

--  4.2.3 Ar --> Arunachal Pradesh
    
UPDATE sales_altered 
SET ship_state = 'Arunachal Pradesh'
WHERE
    ship_state = 'Ar'

--  4.2.4 Rajshthan and Rajsthan -->Rajasthan
    
UPDATE sales_altered 
SET ship_state = 'Rajasthan'
WHERE 
    ship_state ='Rajsthan'
    OR ship_state ='Rajshthan'

--  4.2.5 Jammu & Kashmir --> Jammu and Kashmir
    
UPDATE sales_altered 
SET ship_state = 'Jammu and Kashmir'
WHERE 
    ship_state ='Jammu & Kashmir'
    
--  4.2.6 Dadra And Nagar --> Dadra and Nagar Haveli and Daman and Diu

UPDATE sales_altered 
SET ship_state = 'Dadra and Nagar Haveli and Daman and Diu'
WHERE 
    ship_state ='Dadra And Nagar'

--  4.2.7 Punjab/Mohali/Zirakpur (state/district/city) -->  Punjab

UPDATE sales_altered 
SET ship_state = 'Punjab'
WHERE 
    ship_state ='Punjab/Mohali/Zirakpur'

--  4.2.8 There is no city or state like Apo, so we delete this row
    
DELETE
FROM sales_altered 
WHERE ship_state = 'Apo'

--  4.2.9 New Delhi? --> Delhi

UPDATE sales_altered 
SET ship_state = 'Delhi'
WHERE 
    ship_state ='New Delhi'

--  4.2.10 Nl? --> Nagaland

UPDATE sales_altered 
SET ship_state = 'Nagaland'
WHERE 
    ship_state ='Nl'
    
--  4.2.11 Orissa? --> Odisha
    
UPDATE sales_altered 
SET ship_state = 'Odisha'
WHERE 
    ship_state ='Orissa'
    
--  4.2.12 Pb? --> Punjab
    
UPDATE sales_altered 
SET ship_state = 'Punjab'
WHERE 
    ship_state ='Pb'
    
--  4.2.13 Pondicherry? --> Puducherry

UPDATE sales_altered 
SET ship_state = 'Puducherry'
WHERE 
    ship_state ='Pondicherry'
    
--  4.2.14 Rj? --> Rajasthan

UPDATE sales_altered 
SET ship_state = 'Rajasthan'
WHERE 
    ship_state ='Rj'