-- depends_on: {{ ref('ad_analytics_master_table') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__daily_event_count',
    grain='day',
    dimensions=[],
    secondary_calculations=[]
) }}
