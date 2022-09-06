-- depends_on: {{ ref('ad_analytics_master_table') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__monthly_avg_roas',
    grain='month',
    dimensions=[],
    secondary_calculations=[]
) }}
