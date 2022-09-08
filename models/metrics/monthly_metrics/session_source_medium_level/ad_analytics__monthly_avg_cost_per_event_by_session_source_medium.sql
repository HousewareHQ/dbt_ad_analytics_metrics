-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__monthly_avg_cost_per_event_by_session_source_medium',
    grain='month',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}
