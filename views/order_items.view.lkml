view: order_items {

  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  parameter: metric_selector {
    type: string
    description: "Used as a filter to switch between KPI's"
    allowed_value: {
      label: "3"
      value: "three"
    }
    allowed_value: {
      label: "4"
      value: "four"
    }
    allowed_value: {
      label: "12"
      value: "twelve"
    }
  }
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
   link: {
     url: "https://gcpl230.cloud.looker.com/dashboards/364?&f[order_items.id]={{ value }}"
   }

  }
  measure: avg {
    type: average
    sql: ${id};;
    drill_fields: [id]
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      day_of_week,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_month_num,
      hour_of_day
    ]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: dyn {
    type: date
    datatype: date
    sql: cast(${returned_date} as STRING);;
    convert_tz: no
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }




  dimension: hire {
    type: yesno
    sql: ${returned_date}=${returned_month} ;;
  }
  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
  measure: m1 {
    type: count_distinct
    sql: ${id}
    ;;
    filters: [hire: "yes"]
  }
  measure: m2 {
    type: count_distinct
    sql: ${id} ;;
  }
  measure: m3 {
    type: number
    sql: ${m2}-${m1}
    ;;
    drill_fields: [order_id,returned_date]
  }

  }
