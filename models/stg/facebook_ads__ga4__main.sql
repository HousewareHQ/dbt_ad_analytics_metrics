
{{ config(materialized = 'table') }}

with facebook_ads_main as (
  select *
  from {{ ref('ads__main') }}
  where channel_name = 'Facebook Ads'

), ga4_source_medium__main__facebook_ads as (
  select *
  from {{ ref('ga4_source_medium__main') }}
  where session_source = 'facebook ads'

), source as (

  select coalesce(date_day, date) as date,

         ga4_source_medium__main__facebook_ads.session_source,
         ga4_source_medium__main__facebook_ads.session_medium,
         ga4_source_medium__main__facebook_ads.session_source_medium,
         ga4_source_medium__main__facebook_ads.conversions,
         ga4_source_medium__main__facebook_ads.total_users,
         ga4_source_medium__main__facebook_ads.events_per_session,
         ga4_source_medium__main__facebook_ads.event_count,
         ga4_source_medium__main__facebook_ads.engagement_rate,
         ga4_source_medium__main__facebook_ads.user_engagement_duration,
         ga4_source_medium__main__facebook_ads.engaged_sessions,
         ga4_source_medium__main__facebook_ads.total_revenue,
         ga4_source_medium__main__facebook_ads.sessions,
         ga4_source_medium__main__facebook_ads.new_users,

         facebook_ads_main.ad_id,
         facebook_ads_main.ad_name,
         facebook_ads_main.ad_group_id,
         facebook_ads_main.ad_group_name,
         facebook_ads_main.campaign_id,
         facebook_ads_main.campaign_name,
         facebook_ads_main.impressions,
         facebook_ads_main.clicks,
         facebook_ads_main.spend,
         facebook_ads_main.cost_per_impression,
         facebook_ads_main.cost_per_click,
         facebook_ads_main.cost_per_conversion,
         facebook_ads_main.click_through_rate

  from ga4_source_medium__main__facebook_ads

  full outer join facebook_ads_main
  on ga4_source_medium__main__facebook_ads.date = facebook_ads_main.date_day

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
