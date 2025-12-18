--SANITY CHECK (ALWAYS FIRST IN REAL JOBS)
SELECT COUNT(*) FROM customer_churn;
SELECT churned, COUNT(*)
FROM customer_churn
GROUP BY churned;

--OVERALL CHURN RATE (EXECUTIVE KPI)
SELECT
    ROUND(
        SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)::DECIMAL
        / COUNT(*) * 100, 2
    ) AS churn_rate_percentage
FROM customer_churn;


--MONTHLY REVENUE LOST DUE TO CHURN
SELECT
    ROUND(SUM(monthly_fee), 2) AS monthly_revenue_lost
FROM customer_churn
WHERE churned = 'Yes';


--CHURN BY SUBSCRIPTION PLAN
SELECT
    subscription_plan,
    COUNT(*) AS churned_customers,
    ROUND(SUM(monthly_fee), 2) AS revenue_lost,
    ROUND(AVG(monthly_fee), 2) AS avg_fee
FROM customer_churn
WHERE churned = 'Yes'
GROUP BY subscription_plan
ORDER BY revenue_lost DESC;


--CHURN RATE BY PAYMENT METHOD
SELECT
    payment_method,
    ROUND(
        SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)::DECIMAL
        / COUNT(*) * 100, 2
    ) AS churn_rate
FROM customer_churn
GROUP BY payment_method
ORDER BY churn_rate DESC;


--TENURE ANALYSIS
SELECT
    churned,
    ROUND(AVG(tenure_months), 1) AS avg_tenure
FROM customer_churn
GROUP BY churned;


--HIGH-VALUE CUSTOMER CHURN
SELECT
    subscription_plan,
    COUNT(*) AS churned_customers,
    ROUND(SUM(monthly_fee), 2) AS revenue_lost
FROM customer_churn
WHERE churned = 'Yes'
  AND monthly_fee > 80
GROUP BY subscription_plan
ORDER BY revenue_lost DESC;







