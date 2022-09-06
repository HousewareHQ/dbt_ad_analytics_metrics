-- depends_on: {{ ref('ad_analytics_master_table') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__monthly_number_of_total_users_by_session_source_medium',
    grain='month',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}
