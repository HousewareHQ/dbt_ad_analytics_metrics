-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__monthly_avg_ga4_cost_per_conversion_by_session_source_medium'),
    grain='month',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}
