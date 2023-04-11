view: lst_cnt {
  derived_table: {
    sql: select * from orders where hr = lst_hour;;
  }
  dimension: cnt_lst {
    sql: ${TABLE}.cnt;;
  }
 }
