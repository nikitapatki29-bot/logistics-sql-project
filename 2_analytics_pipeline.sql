-- STEP 3: Create the dynamic business view to track shipment trends
CREATE OR REPLACE VIEW `logistics_data_warehouse.vw_monthly_consignment_trends` AS
SELECT
  created_at AS shipment_date,
  status,
  COUNT(consignment_id) AS total_consignments,
  -- Reaching back exactly one row to get the previous count
  LAG(COUNT(consignment_id)) OVER(ORDER BY created_at) AS previous_month_consignments
FROM
  `logistics_data_warehouse.optimized_consignments`
GROUP BY
  created_at, status;
