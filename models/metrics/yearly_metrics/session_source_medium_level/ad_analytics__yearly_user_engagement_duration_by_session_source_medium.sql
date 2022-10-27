-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__yearly_user_engagement_duration_by_session_source_medium'),
    grain='year',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}
