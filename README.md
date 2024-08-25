# Amazon_Sales_Project
Analysis of 3 months worth of Amazon India Sales data.
Datasets used for this project:
1. https://www.kaggle.com/datasets/thedevastator/unlock-profits-with-e-commerce-sales-data/data?select=Amazon+Sale+Report.csv
2. https://github.com/recurze/IndianCities/blob/master/final_states.csv
## Project goals
Our Amazon sales data analysis project aims to identify the best-selling products in the provided dataset. Through a thorough examination, we seek to uncover which items are generating the most revenue.
## Terms and Definitions
-Set - in this context, it is indicating that the product sold is a bundled offering rather than a single item. To get the clear understanding what the Sets are, use ASIN (Amazon Standard Identification Number);
-Kurta - a long loose-fitting collarless shirt of a style originating in India;
-INR ₹ - Indian rupee.
## Project stages
1. Connected Amazon Sales Database to PgAdmin;
2. Connected PostgreSQL Database to DBeaver;
3. Performed Data cleaning (all of the stages and respective code are shown in sales_data_cleaning.sql)
4. Conducted data analysis using PostgreSQL to determine the best-selling item. Queries yielded the following data: KPIs such as total sales and number of orders; sales per category; average price of items sold per category; total sales by day of week and month; top 10 best-selling sizes for each category; and regional sales performance;
5. Created a simple interactive Tableau dashboard for reporting, featuring:
    - Time-series visualization of total sales;
    - Pie charts of sales per category;
    - Choropleth map displaying sales magnitude per Indian state (also usable as a filter for region-specific insights);
    - Table of top 10 best-selling sizes for each category.
## Functions and techniques
-Aggregation functions - COUNT(), SUM();
-CTEs - sales_per_category, qty_per_category;
-INNER JOIN;
-TO_CHAR (date, ‘Month’), TO_CHAR(date, ‘Dy’);
-Window Function - RANK() OVER(ORDER BY *total_in_millions* DESC);
-Subquery in FROM clause;
## Results
The top three best-performing items in sales are sets, kurtas, and western dresses. Sets, the best-performing product, contributed 49.88% to the total sales volume, reinforcing its market leadership in its category—especially sets available in S, M, L, and XL sizes.
For the main part of the analysis, an interactive dashboard in Tableau was created, accessible via this [link](https://public.tableau.com/views/AmazonSales_17241613013840/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
![Dashboard 1](https://github.com/user-attachments/assets/15bce8f4-9cf2-4c01-abee-f369acb777c6)
Additional insights that could prove helpful in creating a marketing strategy for the product:
- The highest sales volumes were recorded in Maharashtra, Karnataka, and Telangana states, with ₹13.32M, ₹10.47M, and ₹6.91M in sales respectively.
- The top-performing days of the week are Tuesdays, Saturdays, and Sundays.
## Future steps
While the analysis provided key products to focus on, it didn't uncover the most crucial detail—profitability.
To identify the most profitable item, further analysis is necessary. This should include a cost structure analysis, encompassing manufacturing, procurement, and shipping costs. Additionally, operating expenses such as warehousing, distribution, and marketing costs must be examined to understand their impact on profitability.
