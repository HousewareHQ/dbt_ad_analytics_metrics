-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__monthly_avg_ga4_cost_per_conversion',
    grain='month',
    dimensions=[],
    secondary_calculations=[]
) }}
