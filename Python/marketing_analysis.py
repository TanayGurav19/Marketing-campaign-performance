import pandas as pd

# ==========================================
# LOAD DATA
# ==========================================

df = pd.read_csv("../Data/marketing_campaign_data.csv")

print("Original dataset shape:", df.shape)


# ==========================================
# 1. Convert Date to datetime
# ==========================================

df["Date"] = pd.to_datetime(df["Date"])


# ==========================================
# 2. Check missing values
# ==========================================

print("\nMissing values:")
print(df.isnull().sum())


# ==========================================
# 3. Check duplicates
# ==========================================

print("\nDuplicate rows:", df.duplicated().sum())


# ==========================================
# 4. Check logical consistency
# ==========================================

print("\nLogical checks:")

print(
    "Clicks greater than impressions:",
    (df["Clicks"] > df["Impressions"]).sum()
)

print(
    "Leads greater than clicks:",
    (df["Leads"] > df["Clicks"]).sum()
)

print(
    "Conversions greater than leads:",
    (df["Conversions"] > df["Leads"]).sum()
)

print(
    "Negative marketing spend:",
    (df["Marketing_Spend"] < 0).sum()
)

print(
    "Negative revenue:",
    (df["Revenue"] < 0).sum()
)


# ==========================================
# 5. Create calculated marketing metrics
# ==========================================

df["CTR"] = (
    df["Clicks"] / df["Impressions"] * 100
).round(2)

df["Lead_Rate"] = (
    df["Leads"] / df["Clicks"] * 100
).round(2)

df["Conversion_Rate"] = (
    df["Conversions"] / df["Clicks"] * 100
).round(2)

df["CPC"] = (
    df["Marketing_Spend"] / df["Clicks"]
).round(2)

df["CPA"] = (
    df["Marketing_Spend"] / df["Conversions"]
).round(2)

df["ROAS"] = (
    df["Revenue"] / df["Marketing_Spend"]
).round(2)

df["ROI"] = (
    (df["Revenue"] - df["Marketing_Spend"])
    / df["Marketing_Spend"] * 100
).round(2)


# ==========================================
# 6. Create Month column
# ==========================================

df["Month"] = df["Date"].dt.month_name()

df["Month_Number"] = df["Date"].dt.month


# ==========================================
# 7. Save cleaned dataset
# ==========================================

output_path = "../Data/marketing_campaign_cleaned.csv"

df.to_csv(
    output_path,
    index=False
)


# ==========================================
# 8. Display final dataset
# ==========================================

print("\nFinal dataset shape:", df.shape)

print("\nFinal columns:")
print(df.columns.tolist())

print("\nSample calculated metrics:")
print(
    df[
        [
            "CTR",
            "Conversion_Rate",
            "CPC",
            "CPA",
            "ROAS",
            "ROI"
        ]
    ].head()
)

print("\nCleaned dataset saved successfully!")

# ==========================================
# EXPLORATORY DATA ANALYSIS
# ==========================================

print("\n\n==========================================")
print("EXPLORATORY DATA ANALYSIS")
print("==========================================")


# ==========================================
# 1. Overall Marketing Performance
# ==========================================

print("\n========== OVERALL PERFORMANCE ==========")

print("Total Marketing Spend: ₹{:,.2f}".format(
    df["Marketing_Spend"].sum()
))

print("Total Revenue: ₹{:,.2f}".format(
    df["Revenue"].sum()
))

print("Total Impressions: {:,}".format(
    df["Impressions"].sum()
))

print("Total Clicks: {:,}".format(
    df["Clicks"].sum()
))

print("Total Leads: {:,}".format(
    df["Leads"].sum()
))

print("Total Conversions: {:,}".format(
    df["Conversions"].sum()
))

print("Overall ROAS: {:.2f}".format(
    df["Revenue"].sum() / df["Marketing_Spend"].sum()
))


# ==========================================
# 2. Channel Performance
# ==========================================

print("\n========== CHANNEL PERFORMANCE ==========")

channel_analysis = df.groupby("Channel").agg(
    Spend=("Marketing_Spend", "sum"),
    Revenue=("Revenue", "sum"),
    Impressions=("Impressions", "sum"),
    Clicks=("Clicks", "sum"),
    Leads=("Leads", "sum"),
    Conversions=("Conversions", "sum")
)

channel_analysis["CTR"] = (
    channel_analysis["Clicks"]
    / channel_analysis["Impressions"] * 100
).round(2)

channel_analysis["Conversion_Rate"] = (
    channel_analysis["Conversions"]
    / channel_analysis["Clicks"] * 100
).round(2)

channel_analysis["CPA"] = (
    channel_analysis["Spend"]
    / channel_analysis["Conversions"]
).round(2)

channel_analysis["ROAS"] = (
    channel_analysis["Revenue"]
    / channel_analysis["Spend"]
).round(2)

print(channel_analysis.round(2))


# ==========================================
# 3. Campaign Performance
# ==========================================

print("\n========== CAMPAIGN PERFORMANCE ==========")

campaign_analysis = df.groupby("Campaign").agg(
    Spend=("Marketing_Spend", "sum"),
    Revenue=("Revenue", "sum"),
    Clicks=("Clicks", "sum"),
    Leads=("Leads", "sum"),
    Conversions=("Conversions", "sum")
)

campaign_analysis["ROAS"] = (
    campaign_analysis["Revenue"]
    / campaign_analysis["Spend"]
).round(2)

campaign_analysis["CPA"] = (
    campaign_analysis["Spend"]
    / campaign_analysis["Conversions"]
).round(2)

print(campaign_analysis.round(2))


# ==========================================
# 4. Customer Type Analysis
# ==========================================

print("\n========== CUSTOMER TYPE ==========")

customer_analysis = df.groupby("Customer_Type").agg(
    Spend=("Marketing_Spend", "sum"),
    Revenue=("Revenue", "sum"),
    Conversions=("Conversions", "sum")
)

customer_analysis["ROAS"] = (
    customer_analysis["Revenue"]
    / customer_analysis["Spend"]
).round(2)

print(customer_analysis.round(2))


# ==========================================
# 5. Age Group Analysis
# ==========================================

print("\n========== AGE GROUP PERFORMANCE ==========")

age_analysis = df.groupby("Age_Group").agg(
    Spend=("Marketing_Spend", "sum"),
    Revenue=("Revenue", "sum"),
    Conversions=("Conversions", "sum")
)

age_analysis["ROAS"] = (
    age_analysis["Revenue"]
    / age_analysis["Spend"]
).round(2)

print(age_analysis.round(2))


# ==========================================
# 6. Location Analysis
# ==========================================

print("\n========== LOCATION PERFORMANCE ==========")

location_analysis = df.groupby("Location").agg(
    Spend=("Marketing_Spend", "sum"),
    Revenue=("Revenue", "sum"),
    Conversions=("Conversions", "sum")
)

location_analysis["ROAS"] = (
    location_analysis["Revenue"]
    / location_analysis["Spend"]
).round(2)

print(location_analysis.round(2))


# ==========================================
# 7. Monthly Performance
# ==========================================

print("\n========== MONTHLY PERFORMANCE ==========")

monthly_analysis = df.groupby(
    ["Month_Number", "Month"]
).agg(
    Spend=("Marketing_Spend", "sum"),
    Revenue=("Revenue", "sum"),
    Conversions=("Conversions", "sum")
).sort_index()

monthly_analysis["ROAS"] = (
    monthly_analysis["Revenue"]
    / monthly_analysis["Spend"]
).round(2)

print(monthly_analysis.round(2))


# ==========================================
# EDA COMPLETE
# ==========================================

print("\n==========================================")
print("EDA COMPLETE")
print("==========================================")

# ==========================================
# CREATE SQLITE DATABASE
# ==========================================

import sqlite3

# Connect to SQLite database
connection = sqlite3.connect("../Data/marketing_campaign.db")

# Save cleaned dataframe into SQLite
df.to_sql(
    "marketing_campaign",
    connection,
    if_exists="replace",
    index=False
)

connection.close()

print("\nSQLite database created successfully!")