-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('ad_analytics__monthly_number_of_total_users_by_session_source_medium'),
    grain='month',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}
