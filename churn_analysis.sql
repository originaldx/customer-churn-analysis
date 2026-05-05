-- Step 1: Check total customers
SELECT COUNT(*) AS total_customers
FROM churn_data;

-- Step 2: Overall churn distribution
SELECT Churn, COUNT(*) AS count
FROM churn_data
GROUP BY Churn;

-- Step 3: Overall churn rate
SELECT
    CAST(COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS churn_rate
FROM churn_data;

-- Step 4: Churn by Contract Type
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS churn_rate
FROM churn_data
GROUP BY Contract;

-- Step 5: Avg Monthly Charges by Churn
SELECT 
    Churn,
    COUNT(*) AS total_customers,
    AVG(MonthlyCharges) AS avg_monthly_charge
FROM churn_data
GROUP BY Churn;

-- Step 6: Tech Support vs Churn
SELECT 
    TechSupport,
    Churn,
    COUNT(*) AS total
FROM churn_data
GROUP BY TechSupport, Churn
ORDER BY TechSupport;

-- Step 7: High-risk segments
SELECT 
    Contract,
    TechSupport,
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS churn_rate
FROM churn_data
GROUP BY Contract, TechSupport, InternetService
ORDER BY churn_rate DESC;
