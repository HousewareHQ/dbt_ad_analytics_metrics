-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__daily_user_engagement_duration',
    grain='day',
    dimensions=[],
    secondary_calculations=[]
) }}
