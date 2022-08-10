{{ config(materialized = 'table') }}
 
 with facebook_ads_metrics_table as (
    select date_day, 
    ad_id, 
    ad_name, 
    ad_set_id as ad_group_id, 
    ad_set_name as ad_group_name, 
    campaign_id, 
    campaign_name, 
    creative_id, 
    creative_name,
    impressions,
    clicks,
    spend,
    cost_per_impression,
    cost_per_click,
    cost_per_conversion,
    click_through_rate,
    'facebook_ads' as identifier
    from {{ ref('facebook_ads_main') }}

 ), google_ads_metrics_table as (
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
   'google_ads' as identifier
   from {{ ref('google_ads_main') }}
 )

 

