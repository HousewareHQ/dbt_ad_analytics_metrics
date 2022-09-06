
{{ config(materialized = 'table') }}

with facebook_ads_master_table as (
  select *
  from {{ ref('ads_master_table') }}
  where channel_name = 'Facebook Ads'

), analytics_source_medium_master_table as (
  select *
  from {{ ref('analytics_source_medium_master_table') }}
  where session_source = 'facebook ads'

), source as (

  select coalesce(date_day, date) as date,

         analytics_source_medium_master_table.session_source,
         analytics_source_medium_master_table.session_medium,
         analytics_source_medium_master_table.session_source_medium,
         analytics_source_medium_master_table.conversions,
         analytics_source_medium_master_table.total_users,
         analytics_source_medium_master_table.events_per_session,
         analytics_source_medium_master_table.event_count,
         analytics_source_medium_master_table.engagement_rate,
         analytics_source_medium_master_table.user_engagement_duration,
         analytics_source_medium_master_table.engaged_sessions,
         analytics_source_medium_master_table.total_revenue,
         analytics_source_medium_master_table.sessions,
         analytics_source_medium_master_table.new_users,

         facebook_ads_master_table.ad_id,
         facebook_ads_master_table.ad_name,
         facebook_ads_master_table.ad_group_id,
         facebook_ads_master_table.ad_group_name,
         facebook_ads_master_table.campaign_id,
         facebook_ads_master_table.campaign_name,
         facebook_ads_master_table.impressions,
         facebook_ads_master_table.clicks,
         facebook_ads_master_table.spend,
         facebook_ads_master_table.cost_per_impression,
         facebook_ads_master_table.cost_per_click,
         facebook_ads_master_table.cost_per_conversion,
         facebook_ads_master_table.click_through_rate

  from analytics_source_medium_master_table

  full outer join facebook_ads_master_table
  on analytics_source_medium_master_table.date = facebook_ads_master_table.date_day

)

select *,
        (case
          when spend is not null and spend != 0 THEN cast ((sessions/spend) as float)
          else null
         end) as cost_per_session,
        (case
          when spend is not null and spend != 0 THEN cast ((conversions/spend) as float)
          else null
         end) as ga4_cost_per_conversion,
        (case
          when spend is not null and spend != 0 THEN cast ((event_count/spend) as float)
          else null
         end) as cost_per_event,
        (case
          when spend is not null and spend != 0 THEN cast ((total_revenue/spend) as float)
          else null
         end) as roas,
        (case
          when spend is not null and spend != 0 THEN cast ((new_users/spend) as float)
          else null
         end) as cost_per_new_user

from source
