-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__weekly_number_of_engaged_sessions'),
    grain='week',
    dimensions=[],
    secondary_calculations=[]
) }}
