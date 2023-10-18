view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  filter: end_date_filter {
    type: date
    convert_tz: no
  }
dimension: my_filter{
  type: string
  sql: {% date_start end_date_filter%} ;;
}
  dimension: my_filter_end{
    type: string
    sql: {% date_end end_date_filter%} ;;
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }
  dimension: city {
    drill_fields: [state, city]
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Day"
      value: "day"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Week"
      value: "week"
    }
    allowed_value: {
      label: "Quarterly"
      value: "quarterly"
    }
    allowed_value: {
      label: "Year"
      value: "year"
    }
  }

  dimension: date {
    sql:
    {% if date_granularity._parameter_value == 'day' %}
      ${created_date}
    {% elsif date_granularity._parameter_value == 'month' %}
      ${created_month}
      {% elsif date_granularity._parameter_value == 'week' %}
      ${created_week}
      {% elsif date_granularity._parameter_value == 'quarterly' %}
      ${created_quarter}
      {% elsif date_granularity._parameter_value == 'year' %}
      ${created_year}
    {% else %}
      ${created_date}
    {% endif %};;
  }
  filter: created_year_filter {
    type: string
    suggest_dimension: created_year_string
    suggest_explore: users
    sql: {% condition created_year_filter %} ${created_year} {% endcondition %};;
  }
  filter: created_month_filter {
    type: string
    suggest_dimension: created_month
    suggest_explore: users
    sql: {% condition created_month_filter %} ${created_month} {% endcondition %};;
  }



  dimension: created_year_string {
    type: string
    sql: ${created_year} ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }
  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  first_name,
  last_name,
  events.count,
  orders.count,
  saralooker.count,
  sindhu.count,
  user_data.count
  ]
  }

}
