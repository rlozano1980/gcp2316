datagroup: rt_daily {
  max_cache_age: "24 hours"
  description: "Daily caching policy for risk and trading reports under the bi_reports schema"
  sql_trigger: SELECT MAX(ID) FROM users;;
}

datagroup: daily {
  max_cache_age: "24 hours"
  description: "Daily caching policy"
}
