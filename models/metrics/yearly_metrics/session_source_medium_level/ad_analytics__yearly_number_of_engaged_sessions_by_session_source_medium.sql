-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__yearly_number_of_engaged_sessions_by_session_source_medium',
    grain='year',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}
