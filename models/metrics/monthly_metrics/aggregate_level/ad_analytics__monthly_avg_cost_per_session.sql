-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__monthly_avg_cost_per_session'),
    grain='month',
    dimensions=[],
    secondary_calculations=[]
) }}
