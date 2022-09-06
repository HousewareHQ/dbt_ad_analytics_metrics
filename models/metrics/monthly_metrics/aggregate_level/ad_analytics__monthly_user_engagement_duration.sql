-- depends_on: {{ ref('ad_analytics_master_table') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__monthly_user_engagement_duration',
    grain='month',
    dimensions=[],
    secondary_calculations=[]
) }}
