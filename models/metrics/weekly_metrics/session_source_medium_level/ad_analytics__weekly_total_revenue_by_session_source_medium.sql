-- depends_on: {{ ref('ad_analytics_master_table') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__weekly_total_revenue_by_session_source_medium',
    grain='week',
    dimensions=['session_source_medium'],
    secondary_calculations=[]
) }}
