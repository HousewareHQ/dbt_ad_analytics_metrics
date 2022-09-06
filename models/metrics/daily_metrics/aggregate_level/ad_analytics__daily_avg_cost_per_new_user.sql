-- depends_on: {{ ref('ad_analytics_master_table') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__daily_avg_cost_per_new_user',
    grain='day',
    dimensions=[],
    secondary_calculations=[]
) }}
