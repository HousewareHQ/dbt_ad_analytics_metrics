-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__daily_number_of_events_per_session'),
    grain='day',
    dimensions=[],
    secondary_calculations=[]
) }}
