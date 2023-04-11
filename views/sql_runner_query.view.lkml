view: sql_runner_query {
  derived_table: {
    sql: SELECT
          orders.id  AS `orders.cnt`,
              (DATE(CONVERT_TZ(orders.created_at ,'UTC','America/Los_Angeles'))) AS `orders.created_date`,
              (CASE WHEN ( HOUR(CONVERT_TZ(orders.created_at ,'UTC','America/Los_Angeles')) )=( MAX((HOUR(CONVERT_TZ(orders.created_at ,'UTC','America/Los_Angeles'))))) THEN 'Yes' ELSE 'No' END) AS `orders.yesno`
      FROM demo_db.orders  AS orders
      WHERE ((( orders.created_at  ) >= (CONVERT_TZ(TIMESTAMP('2019-01-01'),'America/Los_Angeles','UTC')) AND ( orders.created_at  ) < (CONVERT_TZ(TIMESTAMP('2019-01-10'),'America/Los_Angeles','UTC'))))
      GROUP BY
          1,
          2
      ORDER BY
          (CASE WHEN ( HOUR(CONVERT_TZ(orders.created_at ,'UTC','America/Los_Angeles')) )=( MAX((HOUR(CONVERT_TZ(orders.created_at ,'UTC','America/Los_Angeles'))))) THEN 'Yes' ELSE 'No' END) DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orders_cnt {
    type: number
    sql: ${TABLE}.`orders.cnt` ;;
  }

  dimension: orders_created_date {
    type: date
    sql: ${TABLE}.`orders.created_date` ;;
  }

  dimension: orders_yesno {
    type: string
    sql: ${TABLE}.`orders.yesno` ;;
  }

  set: detail {
    fields: [orders_cnt, orders_created_date, orders_yesno]
  }
}
