-- depends_on: {{ ref('ad_analytics_master_table') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='ad_analytics__yearly_total_revenue',
    grain='year',
    dimensions=[],
    secondary_calculations=[]
) }}
