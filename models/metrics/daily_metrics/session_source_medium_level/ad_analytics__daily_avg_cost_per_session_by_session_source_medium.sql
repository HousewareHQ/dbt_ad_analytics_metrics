-- depends_on: {{ ref('ad_analytics_master_table') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__daily_avg_cost_per_session_by_session_source_medium',
    grain='day',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}