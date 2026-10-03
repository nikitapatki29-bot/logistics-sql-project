-- STEP 1: Create the raw, unoptimized data table
CREATE OR REPLACE TABLE `logistics_data_warehouse.unoptimized_consignments` AS
SELECT 
  order_id AS consignment_id,
  user_id AS customer_id,
  status,
  gender,
  created_at,
  shipped_at,
  delivered_at,
  num_of_item AS total_items
FROM 
  `bigquery-public-data.thelook_ecommerce.orders`;


-- STEP 2: Create the optimized table using Partitioning and Clustering
CREATE OR REPLACE TABLE `logistics_data_warehouse.optimized_consignments`
PARTITION BY DATE(created_at)
CLUSTER BY status AS
SELECT * FROM `logistics_data_warehouse.unoptimized_consignments`;
