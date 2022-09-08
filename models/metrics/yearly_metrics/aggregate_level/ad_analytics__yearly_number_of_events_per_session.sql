-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__yearly_number_of_events_per_session',
    grain='year',
    dimensions=[],
    secondary_calculations=[]
) }}
