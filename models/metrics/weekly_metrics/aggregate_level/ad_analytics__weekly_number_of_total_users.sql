-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__weekly_number_of_total_users'),
    grain='week',
    dimensions=[],
    secondary_calculations=[]
) }}
