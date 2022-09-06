
{{ config(materialized = 'table') }}

with ga4_first_user_source_medium as (
  select *
  from {{ ref('ga4_first_user_source_medium') }}

), ga4_traffic_source_medium as (
  select *
  from {{ ref('ga4_traffic_source_medium') }}

), analytics_source_medium_master_table as (

  select coalesce(ga4_traffic_source_medium.date, ga4_first_user_source_medium.date) date,
         coalesce(ga4_traffic_source_medium.session_medium, ga4_first_user_source_medium.first_user_medium) session_medium,
         coalesce(ga4_traffic_source_medium.session_source, ga4_first_user_source_medium.first_user_source) session_source,
         ga4_traffic_source_medium.conversions,
         ga4_traffic_source_medium.total_users,
         ga4_traffic_source_medium.events_per_session,
         ga4_traffic_source_medium.event_count,
         ga4_traffic_source_medium.engagement_rate,
         ga4_traffic_source_medium.user_engagement_duration,
         ga4_traffic_source_medium.engaged_sessions,
         ga4_traffic_source_medium.total_revenue,
         ga4_traffic_source_medium.sessions,
         ga4_first_user_source_medium.new_users,

         concat('(', session_source, ') / (', session_medium, ')') as session_source_medium

  from ga4_traffic_source_medium

  full outer join ga4_first_user_source_medium
  on ga4_first_user_source_medium.first_user_source = ga4_traffic_source_medium.session_source
  and ga4_first_user_source_medium.first_user_medium = ga4_traffic_source_medium.session_medium
  and ga4_first_user_source_medium.date = ga4_traffic_source_medium.date
)

select * from analytics_source_medium_master_table
