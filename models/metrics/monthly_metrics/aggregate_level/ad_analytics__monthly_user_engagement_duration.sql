-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__monthly_user_engagement_duration'),
    grain='month',
    dimensions=[],
    secondary_calculations=[]
) }}
