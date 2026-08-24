import pandas as pd
import numpy as np

file_name = "2020_al_data_kaggle_upload_new_old_syllabi.csv"

print("=" * 60)
print("1. LOADING AND CLEANING DATASET")
print("=" * 60)

# Load data treating '-' and spaces as NaN
df = pd.read_csv(file_name, na_values=["-", "", " ", "Absent"])

# Convert Zscore to numeric
if "Zscore" in df.columns:
    df["Zscore"] = pd.to_numeric(df["Zscore"], errors="coerce")

# Extract numeric values from rank strings (e.g. '4336 (NEW)' -> 4336)
for rank_col in ["district_rank", "island_rank"]:
    if rank_col in df.columns:
        df[f"{rank_col}_num"] = (
            df[rank_col]
            .astype(str)
            .str.extract(r"(\d+)")
            .astype(float)
        )

print(f"Total Records (Rows): {df.shape[0]:,}")
print(f"Total Columns:        {df.shape[1]}")
print(f"Duplicate Rows:       {df.duplicated().sum():,}")

print("\n" + "=" * 60)
print("2. COLUMN HEALTH & MISSING VALUES")
print("=" * 60)
overview = pd.DataFrame({
    "Data Type": df.dtypes,
    "Missing Count": df.isnull().sum(),
    "Missing (%)": (df.isnull().mean() * 100).round(2),
    "Unique Values": df.nunique()
})
print(overview.to_string())

print("\n" + "=" * 60)
print("3. NUMERIC SUMMARY STATISTICS")
print("=" * 60)
numeric_summary = df.describe().T
print(numeric_summary.to_string())

print("\n" + "=" * 60)
print("4. CATEGORICAL DISTRIBUTIONS (TOP 5 VALUES PER COLUMN)")
print("=" * 60)
categorical_cols = df.select_dtypes(include=["object", "category"]).columns

for col in categorical_cols:
    print(f"\n--- Distribution: {col} ---")
    val_counts = df[col].value_counts(dropna=False).head(5)
    percentages = (df[col].value_counts(normalize=True, dropna=False) * 100).round(2).head(5)
    dist_df = pd.DataFrame({"Count": val_counts, "Percentage (%)": percentages})
    print(dist_df.to_string())

# Export summary to CSV files for easy review
overview.to_csv("profile_column_health.csv")
numeric_summary.to_csv("profile_numeric_summary.csv")
print("\n[Done] Summary tables exported to 'profile_column_health.csv' and 'profile_numeric_summary.csv'.")