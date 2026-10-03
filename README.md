# Logistics SQL Optimization Project

## 📌 Project Overview
This project uses Google BigQuery to simulate a real-world logistics and freight database. The goal was to take a raw dataset and optimize its structure to speed up queries, lower cloud costs, and build a clean reporting layer.

## 🛠️ Database Optimization
To prevent slow full-table scans and save computing power, I restructured how the data is physically stored:
*   **Table Partitioning:** Grouped data by the `created_at` date so BigQuery only scans folders for requested dates.
*   **Table Clustering:** Sorted records by delivery `status` within those dates to accelerate filtering.

**Result:** The optimized table drastically lowered the **Bytes Processed** during search operations compared to the unoptimized table.

## 📈 Data Pipelines & Views
*   Created a **SQL View** (`vw_monthly_consignment_trends`) to track shipping volume trends.
*   Used the **`LAG()` window function** to automatically pull historical shipment totals side-by-side without slowing down the database with heavy self-joins.

## 🔍 Performance Verification (How to Test)
You can compare the performance difference by running these two queries in separate tabs. Check the **Job Information** tab at the bottom of the BigQuery screen after each run to see the drop in bytes processed:

### Test 1: Unoptimized Table Scan
```sql
SELECT * 
FROM `logistics_data_warehouse.unoptimized_consignments`
WHERE created_at >= '2023-01-01'
  AND status = 'Shipped';
```

### Test 2: Optimized Table Scan (Low Bytes Processed)
```sql
SELECT * 
FROM `logistics_data_warehouse.optimized_consignments`
WHERE created_at >= '2023-01-01'
  AND status = 'Shipped';
```
