
{{ config(materialized = 'table') }}

 with facebook_ads_main as (
    select date_day,
    ad_id,
    ad_name,
    ad_set_id as ad_group_id,
    ad_set_name as ad_group_name,
    campaign_id,
    campaign_name,
    impressions,
    clicks,
    spend,
    cost_per_impression,
    cost_per_click,
    cost_per_conversion,
    click_through_rate,
    'Facebook Ads' as channel_name
    from {{ ref('facebook_ads_main') }}

 ), google_ads_main as (
   select date_day,
   ad_id,
   ad_name,
   ad_group_id,
   ad_group_name,
   campaign_id,
   campaign_name,
   impressions,
   clicks,
   spend,
   cost_per_impression_per_ad as cost_per_impression,
   cost_per_click_per_ad as cost_per_click,
   cost_per_conversion_per_ad as cost_per_conversion,
   click_through_rate_per_ad as click_through_rate,
   'Google Ads' as channel_name
   from {{ ref('google_ads_main') }}
 ), source as (

   select facebook_ads_main.* from facebook_ads_main
   union all
   select google_ads_main.* from google_ads_main
 )

select *
from source
