USE PRACTICE;

CREATE TABLE SALES(
INVOICE_ID VARCHAR(30) NOT NULL PRIMARY KEY,
BRANCH VARCHAR (5)NOT NULL,
CITY VARCHAR (30) NOT NULL,
CUSTOMER_TYPE VARCHAR(30) NOT NULL,
GENDER VARCHAR (10) NOT NULL,
PRODUCT_LINE VARCHAR (100) NOT NULL,
UNIT_PRICE DECIMAL (10,2) NOT NULL,
QUANTITY INT NOT NULL,
VAT FLOAT (6,4) NOT NULL,
TOTAL DECIMAL (10,2) NOT NULL,
DATE DATETIME NOT NULL,
TIME TIME NOT NULL,
PAYMENT_METHOD VARCHAR (15) NOT NULL,
COGS DECIMAL (10,2) NOT NULL,
GROSS_MARGIN_PERCENTAGE FLOAT(11,9) NOT NULL,
GROSS_INCOME DECIMAL (10,2) NOT NULL,
RATING FLOAT(2,1) NOT NULL
);

SELECT * FROM SALES;

SELECT CITY FROM SALES;

################################################### Feature Engineering ############################################################
## Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.

SELECT * FROM SALES;

SELECT
	TIME,
    (CASE 
		WHEN `TIME` BETWEEN '00.00.00' AND '12.00.00' THEN 'MORNING'
		WHEN `TIME` BETWEEN '12.01.00' AND '16.00.00' THEN 'AFTERNOON'
        ELSE 'EVENING'
	END
    ) AS TIME_OF_DATE
FROM SALES;

ALTER TABLE SALES ADD COLUMN TIME_OF_DAY VARCHAR (20);

UPDATE SALES 
SET TIME_OF_DAY = (
	CASE
		WHEN `TIME` BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
		WHEN `TIME` BETWEEN '12:01:00' AND '16:00:00' THEN 'AFTERNOON'
        ELSE 'EVENING'
	END);

SELECT * FROM SALES;

SELECT DATE FROM SALES;

SELECT DATE,DAYNAME(DATE) AS DAY_NAME FROM SALES;

ALTER TABLE SALES ADD COLUMN DAY_NAME VARCHAR (10);

UPDATE SALES SET DAY_NAME = DAYNAME(DATE);

SELECT DATE, MONTHNAME(DATE) AS MONTH_NAME FROM SALES;

ALTER TABLE SALES ADD COLUMN MONTH_NAME VARCHAR (10);

UPDATE SALES SET MONTH_NAME = MONTHNAME(DATE);

#####################  Generic Question ###############

##### How many unique cities does the data have? ###

SELECT DISTINCT CITY FROM SALES;

####### In which city is each branch? ###

SELECT DISTINCT CITY,BRANCH FROM SALES;

############# Product Question #############
## How many unique product lines does the data have? ##

SELECT * FROM SALES;

SELECT DISTINCT PRODUCT_LINE FROM SALES;

##### What is the most common payment method? ###

SELECT PAYMENT_METHOD, COUNT(PAYMENT_METHOD) AS CNT FROM SALES
GROUP BY PAYMENT_METHOD
ORDER BY CNT DESC;

### What is the most selling product line? ###

SELECT * FROM SALES;

SELECT PRODUCT_LINE, COUNT(PRODUCT_LINE) AS MOST_SELLING FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY MOST_SELLING DESC;

#####  What is the total revenue by month? ######

SELECT * FROM SALES;

SELECT MONTH_NAME AS MONTH, SUM(TOTAL) AS TOTAL_REVENUE FROM SALES
GROUP BY MONTH
ORDER BY TOTAL_REVENUE DESC;

###### What month had the largest COGS? ####

SELECT MONTH_NAME AS MONTH , SUM(COGS) AS COGS FROM SALES
GROUP BY MONTH_NAME
ORDER BY COGS DESC;

###### What product line had the largest revenue? ###

SELECT * FROM SALES;

SELECT PRODUCT_LINE AS LOB, SUM(TOTAL) AS REVENUE FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY REVENUE DESC;

####### What is the city with the largest revenue? ########

SELECT CITY, SUM(TOTAL) AS REVENUE FROM SALES
GROUP BY CITY
ORDER BY REVENUE DESC;

######## What product line had the largest VAT? ############

SELECT PRODUCT_LINE AS LOB , AVG(VAT) AS VAT  FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY VAT DESC;

##### Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales ###

SELECT PRODUCT_LINE,COGS FROM SALES;

#### Which branch sold more products than average product sold? ####

SELECT BRANCH, SUM(QUANTITY) AS QTY FROM SALES
GROUP BY BRANCH;

#### What is the most common product line by gender? ####

SELECT GENDER,PRODUCT_LINE, COUNT(GENDER) AS TOTAL_CNT FROM SALES 
GROUP BY GENDER, PRODUCT_LINE
ORDER BY TOTAL_CNT DESC;

##### What is the average rating of each product line? ######

SELECT PRODUCT_LINE AS LOB, ROUND(AVG(RATING) ,2) AS AVG_RATING FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY AVG_RATING DESC;
 
########################### Sales Question ######################
############### Number of sales made in each time of the day per weekday ###########

SELECT * FROM SALES;

SELECT TIME_OF_DAY , COUNT(COGS) AS TOTAL_SALES FROM SALES
WHERE DAY_NAME = 'SATURDAY'
GROUP BY TIME_OF_DAY
ORDER BY TOTAL_SALES DESC;

############### Which of the customer types brings the most revenue? ##########

SELECT CUSTOMER_TYPE, SUM(TOTAL) AS TOTAL_REVENUE FROM SALES
GROUP BY CUSTOMER_TYPE
ORDER BY TOTAL_REVENUE DESC;

################# Which city has the largest tax percent/ VAT (Value Added Tax)? ##########

SELECT CITY, ROUND(AVG(VAT), 3)AS TAX FROM SALES
GROUP BY CITY
ORDER BY TAX DESC;

############################ Which customer type pays the most in VAT? ##############

SELECT CUSTOMER_TYPE,AVG(VAT) AS TAX FROM SALES
GROUP BY CUSTOMER_TYPE
ORDER BY TAX DESC;

###################################################### Customer Question ##################################################################
#### How many unique customer types does the data have? ######

SELECT DISTINCT CUSTOMER_TYPE FROM SALES;

######## How many unique payment methods does the data have? ###########

SELECT DISTINCT PAYMENT_METHOD FROM SALES;

######## What is the most common customer type? #########

########### Which customer type buys the most? ##############

SELECT CUSTOMER_TYPE, COUNT(QUANTITY) AS CST_CNT FROM SALES
GROUP BY CUSTOMER_TYPE
ORDER BY CST_CNT DESC;

######## What is the gender of most of the customers? ########

SELECT GENDER,COUNT(GENDER) AS GEN FROM SALES
GROUP BY GENDER
ORDER BY GEN DESC;

################### What is the gender distribution per branch? ###################

SELECT * FROM SALES;

SELECT GENDER, COUNT(GENDER) AS GEN FROM SALES
WHERE BRANCH = 'C'
GROUP BY GENDER
ORDER BY GEN DESC;

################### Which time of the day do customers give most ratings? ###################

SELECT TIME_OF_DAY, AVG(RATING) AS RATINGS FROM SALES 
GROUP BY TIME_OF_DAY
ORDER BY RATINGS DESC;

############ Which time of the day do customers give most ratings per branch? #########

SELECT TIME_OF_DAY, AVG(RATING) AS RATINGS FROM SALES 
WHERE BRANCH = 'C'
GROUP BY TIME_OF_DAY
ORDER BY RATINGS DESC;

################# Which day fo the week has the best avg ratings? ##############

SELECT DAY_NAME, AVG(RATING) AS RATINGS FROM SALES 
GROUP BY DAY_NAME
ORDER BY RATINGS DESC;

############### Which day of the week has the best average ratings per branch? ################

SELECT DAY_NAME, AVG(RATING) AS RATINGS FROM SALES
WHERE BRANCH = 'C' 
GROUP BY DAY_NAME
ORDER BY RATINGS DESC;











