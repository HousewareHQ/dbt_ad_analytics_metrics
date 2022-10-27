-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__weekly_total_revenue'),
    grain='week',
    dimensions=[],
    secondary_calculations=[]
) }}
