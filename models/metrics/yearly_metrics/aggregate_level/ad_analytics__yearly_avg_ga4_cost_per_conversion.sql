-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__yearly_avg_ga4_cost_per_conversion'),
    grain='year',
    dimensions=[],
    secondary_calculations=[]
) }}
