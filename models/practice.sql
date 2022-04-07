select
    impressions,
    {{ cents_to_dollars('impressions') }} as amount_usd
from gentle-charmer-297601.adwords.t_ft_gads_campaign_se