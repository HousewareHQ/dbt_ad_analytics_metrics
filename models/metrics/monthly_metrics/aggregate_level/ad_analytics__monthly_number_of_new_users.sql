-- depends_on: {{ ref('ads__analytics__main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__monthly_number_of_new_users',
    grain='month',
    dimensions=[],
    secondary_calculations=[]
) }}
