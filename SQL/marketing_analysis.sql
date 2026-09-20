-- ==========================================
-- MARKETING CAMPAIGN PERFORMANCE ANALYSIS
-- ==========================================


-- ==========================================
-- QUERY 1: OVERALL MARKETING PERFORMANCE
-- ==========================================

SELECT
    SUM(Marketing_Spend) AS Total_Spend,
    SUM(Impressions) AS Total_Impressions,
    SUM(Clicks) AS Total_Clicks,
    SUM(Leads) AS Total_Leads,
    SUM(Conversions) AS Total_Conversions,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,

    ROUND(
        SUM(Clicks) * 100.0 / SUM(Impressions),
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) * 100.0 / SUM(Clicks),
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Marketing_Spend) * 1.0 / SUM(Clicks),
        2
    ) AS CPC,

    ROUND(
        SUM(Marketing_Spend) * 1.0 / SUM(Conversions),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) * 1.0 / SUM(Marketing_Spend),
        2
    ) AS ROAS,

    ROUND(
        (SUM(Revenue) - SUM(Marketing_Spend))
        * 100.0 / SUM(Marketing_Spend),
        2
    ) AS ROI

FROM marketing_campaign;

-- ==========================================
-- QUERY 2: CHANNEL PERFORMANCE
-- ==========================================

SELECT
    Channel,

    SUM(Marketing_Spend) AS Total_Spend,

    SUM(Impressions) AS Total_Impressions,

    SUM(Clicks) AS Total_Clicks,

    SUM(Leads) AS Total_Leads,

    SUM(Conversions) AS Total_Conversions,

    ROUND(SUM(Revenue), 2) AS Total_Revenue,

    ROUND(
        SUM(Clicks) * 100.0 /
        SUM(Impressions),
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) * 100.0 /
        SUM(Clicks),
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Marketing_Spend) * 1.0 /
        SUM(Clicks),
        2
    ) AS CPC,

    ROUND(
        SUM(Marketing_Spend) * 1.0 /
        SUM(Conversions),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) * 1.0 /
        SUM(Marketing_Spend),
        2
    ) AS ROAS

FROM marketing_campaign

GROUP BY Channel

ORDER BY ROAS DESC;

-- ==========================================
-- QUERY 3: CAMPAIGN PERFORMANCE
-- ==========================================

SELECT
    Campaign,

    SUM(Marketing_Spend) AS Total_Spend,

    SUM(Impressions) AS Total_Impressions,

    SUM(Clicks) AS Total_Clicks,

    SUM(Leads) AS Total_Leads,

    SUM(Conversions) AS Total_Conversions,

    ROUND(SUM(Revenue), 2) AS Total_Revenue,

    ROUND(
        SUM(Clicks) * 100.0 /
        SUM(Impressions),
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) * 100.0 /
        SUM(Clicks),
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Marketing_Spend) * 1.0 /
        SUM(Conversions),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) * 1.0 /
        SUM(Marketing_Spend),
        2
    ) AS ROAS

FROM marketing_campaign

GROUP BY Campaign

ORDER BY ROAS DESC;

-- ==========================================
-- QUERY 4: MARKETING FUNNEL
-- ==========================================

SELECT
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Leads) AS Leads,
    SUM(Conversions) AS Conversions,

    ROUND(
        SUM(Clicks) * 100.0 /
        SUM(Impressions),
        2
    ) AS Impression_to_Click_Rate,

    ROUND(
        SUM(Leads) * 100.0 /
        SUM(Clicks),
        2
    ) AS Click_to_Lead_Rate,

    ROUND(
        SUM(Conversions) * 100.0 /
        SUM(Leads),
        2
    ) AS Lead_to_Conversion_Rate

FROM marketing_campaign;

-- ==========================================
-- QUERY 5: CUSTOMER TYPE PERFORMANCE
-- ==========================================

SELECT
    Customer_Type,

    SUM(Marketing_Spend) AS Total_Spend,

    SUM(Conversions) AS Total_Conversions,

    ROUND(SUM(Revenue), 2) AS Total_Revenue,

    ROUND(
        SUM(Revenue) * 1.0 /
        SUM(Marketing_Spend),
        2
    ) AS ROAS,

    ROUND(
        SUM(Marketing_Spend) * 1.0 /
        SUM(Conversions),
        2
    ) AS CPA

FROM marketing_campaign

GROUP BY Customer_Type

ORDER BY Total_Revenue DESC;

-- ==========================================
-- QUERY 6: AGE GROUP PERFORMANCE
-- ==========================================

SELECT
    Age_Group,

    SUM(Marketing_Spend) AS Total_Spend,

    SUM(Clicks) AS Total_Clicks,

    SUM(Conversions) AS Total_Conversions,

    ROUND(SUM(Revenue), 2) AS Total_Revenue,

    ROUND(
        SUM(Conversions) * 100.0 /
        SUM(Clicks),
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Marketing_Spend) * 1.0 /
        SUM(Conversions),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) * 1.0 /
        SUM(Marketing_Spend),
        2
    ) AS ROAS

FROM marketing_campaign

GROUP BY Age_Group

ORDER BY ROAS DESC;

-- ==========================================
-- QUERY 7: GENDER PERFORMANCE
-- ==========================================

SELECT
    Gender,

    SUM(Marketing_Spend) AS Total_Spend,

    SUM(Conversions) AS Total_Conversions,

    ROUND(SUM(Revenue), 2) AS Total_Revenue,

    ROUND(
        SUM(Conversions) * 100.0 /
        SUM(Clicks),
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Revenue) * 1.0 /
        SUM(Marketing_Spend),
        2
    ) AS ROAS

FROM marketing_campaign

GROUP BY Gender

ORDER BY ROAS DESC;

-- ==========================================
-- QUERY 8: LOCATION PERFORMANCE
-- ==========================================

SELECT
    Location,

    SUM(Marketing_Spend) AS Total_Spend,

    SUM(Conversions) AS Total_Conversions,

    ROUND(SUM(Revenue), 2) AS Total_Revenue,

    ROUND(
        SUM(Marketing_Spend) * 1.0 /
        SUM(Conversions),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) * 1.0 /
        SUM(Marketing_Spend),
        2
    ) AS ROAS

FROM marketing_campaign

GROUP BY Location

ORDER BY Total_Revenue DESC;

-- ==========================================
-- QUERY 9: MONTHLY PERFORMANCE
-- ==========================================

SELECT
    strftime('%Y-%m', Date) AS Month,

    SUM(Marketing_Spend) AS Total_Spend,

    SUM(Impressions) AS Total_Impressions,

    SUM(Clicks) AS Total_Clicks,

    SUM(Conversions) AS Total_Conversions,

    ROUND(SUM(Revenue), 2) AS Total_Revenue,

    ROUND(
        SUM(Revenue) * 1.0 /
        SUM(Marketing_Spend),
        2
    ) AS ROAS

FROM marketing_campaign

GROUP BY strftime('%Y-%m', Date)

ORDER BY Month;