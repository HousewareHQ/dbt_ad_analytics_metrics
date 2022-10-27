-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__yearly_user_engagement_duration'),
    grain='year',
    dimensions=[],
    secondary_calculations=[]
) }}
