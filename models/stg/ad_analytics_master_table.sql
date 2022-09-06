
{{ config(materialized = 'table') }}

with facebook_ads_analytics_master_table as (

  select *
  from {{ ref('facebook_ads_analytics_master_table') }}

), google_ads_analytics_master_table as (

  select *
  from {{ ref('google_ads_analytics_master_table') }}

), source as (

  select * from facebook_ads_analytics_master_table
  union all
  select * from google_ads_analytics_master_table
)

select *
from source
