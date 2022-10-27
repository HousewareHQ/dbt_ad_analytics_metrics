-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__weekly_avg_cost_per_new_user'),
    grain='week',
    dimensions=[],
    secondary_calculations=[]
) }}
