
{{ config(materialized='view') }}

WITH ga4_first_user_source_medium AS
  (
    SELECT *
    FROM {{ source('google_analytics_4', var('ga4_first_user_source_medium_report')) }}
  )

select * from ga4_first_user_source_medium
