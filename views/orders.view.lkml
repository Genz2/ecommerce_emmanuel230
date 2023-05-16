view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    link: {
      url: "https://gcpl230.cloud.looker.com/dashboards/364?&f[orders.id]={{ value}}"
    }
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      hour,
      hour_of_day
    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension: hr {
    type: string
    sql: ${created_hour_of_day} ;;
  }
  measure: lst_hour{
    type: max
    #sql:  ${created_hour_of_day};;
    sql: ${hr} ;;
  }
  measure: yesno {
    type: yesno
    sql: ${created_hour_of_day}=${lst_hour};;
  }
  measure: cnt_latest {
    type: number
    sql: (select ${cnt} from orders where ${TABLE}.hr=${TABLE}.lst_hour);;
  }


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  dimension: cnt{
    type: number
    sql: ${id} ;;
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      billion_orders.count,
      fakeorders.count,
      hundred_million_orders.count,
      hundred_million_orders_wide.count,
      order_items.count,
      order_items_vijaya.count,
      ten_million_orders.count
    ]
  }
}
