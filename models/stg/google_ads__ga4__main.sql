
{{ config(materialized = 'table') }}

with google_ads_master_table as (
  select *
  from {{ ref('ads__main') }}
  where channel_name = 'Google Ads'

), ga4_source_medium__main__google_ads as (
  select *
  from {{ ref('ga4_source_medium__main') }}
  where session_source = 'google'
  and session_medium = 'cpc'

), source as (

  select coalesce(date_day, date) as date,

         ga4_source_medium__main__google_ads.session_source,
         ga4_source_medium__main__google_ads.session_medium,
         ga4_source_medium__main__google_ads.session_source_medium,
         ga4_source_medium__main__google_ads.conversions,
         ga4_source_medium__main__google_ads.total_users,
         ga4_source_medium__main__google_ads.events_per_session,
         ga4_source_medium__main__google_ads.event_count,
         ga4_source_medium__main__google_ads.engagement_rate,
         ga4_source_medium__main__google_ads.user_engagement_duration,
         ga4_source_medium__main__google_ads.engaged_sessions,
         ga4_source_medium__main__google_ads.total_revenue,
         ga4_source_medium__main__google_ads.sessions,
         ga4_source_medium__main__google_ads.new_users,

         google_ads_master_table.ad_id,
         google_ads_master_table.ad_name,
         google_ads_master_table.ad_group_id,
         google_ads_master_table.ad_group_name,
         google_ads_master_table.campaign_id,
         google_ads_master_table.campaign_name,
         google_ads_master_table.impressions,
         google_ads_master_table.clicks,
         google_ads_master_table.spend,
         google_ads_master_table.cost_per_impression,
         google_ads_master_table.cost_per_click,
         google_ads_master_table.cost_per_conversion,
         google_ads_master_table.click_through_rate

  from ga4_source_medium__main__google_ads

  full outer join google_ads_master_table
  on ga4_source_medium__main__google_ads.date = google_ads_master_table.date_day

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
