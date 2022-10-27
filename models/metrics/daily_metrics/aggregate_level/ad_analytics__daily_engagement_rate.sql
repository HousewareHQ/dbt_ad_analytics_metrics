-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__daily_engagement_rate'),
    grain='day',
    dimensions=[],
    secondary_calculations=[]
) }}
