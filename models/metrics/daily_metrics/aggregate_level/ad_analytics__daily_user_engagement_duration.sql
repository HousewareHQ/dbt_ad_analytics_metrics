-- depends_on: {{ ref('ad_analytics_master_table') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__daily_user_engagement_duration',
    grain='day',
    dimensions=[],
    secondary_calculations=[]
) }}
