-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__daily_avg_cost_per_session_by_session_source_medium'),
    grain='day',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}
