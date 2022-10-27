-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__weekly_avg_cost_per_new_user_by_session_source_medium'),
    grain='week',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}
