-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__weekly_number_of_sessions',
    grain='week',
    dimensions=[],
    secondary_calculations=[]
) }}
