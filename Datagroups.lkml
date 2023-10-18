datagroup: rt_daily {
  max_cache_age: "24 hours"
  description: "Daily caching policy for risk and trading reports under the bi_reports schema"
  sql_trigger: SELECT MAX(closed_at_date) FROM editor.bi_reports.daily_report_sports_metrics_us;;
}

datagroup: daily {
  max_cache_age: "24 hours"
  description: "Daily caching policy"
}
