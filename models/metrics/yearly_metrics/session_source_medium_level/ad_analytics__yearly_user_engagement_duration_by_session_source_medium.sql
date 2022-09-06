-- depends_on: {{ ref('ad_analytics_master_table') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__yearly_user_engagement_duration_by_session_source_medium',
    grain='year',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}
