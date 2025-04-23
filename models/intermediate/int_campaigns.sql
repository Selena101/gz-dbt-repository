{{ config(materialized='view') }}  -- or 'table' if you prefer a table

-- Create the table by combining all staging tables and performing the necessary transformations

SELECT
    date_date,
    CAST(ads_cost AS FLOAT64) AS ads_cost,  -- Ensures cost is float64
    impression AS ads_impression,           -- Renaming to match target column
    click AS ads_clicks                     -- Renaming to match target column
FROM {{ ref('stg_raw__facebook') }}

UNION ALL

SELECT
    date_date,
    CAST(ads_cost AS FLOAT64) AS ads_cost,
    impression AS ads_impression,
    click AS ads_clicks
FROM {{ ref('stg_raw__adwords') }}

UNION ALL

SELECT
    date_date,
    CAST(ads_cost AS FLOAT64) AS ads_cost,
    impression AS ads_impression,
    click AS ads_clicks
FROM {{ ref('stg_raw__criteo') }}

UNION ALL

SELECT
    date_date,
    CAST(ads_cost AS FLOAT64) AS ads_cost,
    impression AS ads_impression,
    click AS ads_clicks
FROM {{ ref('stg_raw__bing') }}

-- Order the results by date_date in reverse chronological order
ORDER BY date_date DESC