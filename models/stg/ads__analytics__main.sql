
{{ config(materialized = 'table') }}

with facebook_ads__ga4__main as (

  select *
  from {{ ref('facebook_ads__ga4__main') }}

), google_ads__ga4__main as (

  select *
  from {{ ref('google_ads__ga4__main') }}

), source as (

  select * from facebook_ads__ga4__main
  union all
  select * from google_ads__ga4__main
)

select *
from source
