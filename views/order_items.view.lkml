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
    html:

    {% if metric_selector._parameter_value == "'three'" %}
     <div style=" number-format='0.000' ">{{ rendered_value|metric_selector._parameter_value}}</div>
    {% elsif metric_selector._parameter_value == "'four'" %}
     <div style="number-format='0.0000' ">{{ rendered_value }}</div>
    {% endif %}
    ${{ rendered_value}}
    ;;

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

  measure: 4_bar_dry_air {
    label: "4 Bar Dry Air"
    type: average
    sql: ${id} ;;
    value_format: "0.00"
    filters: [order_id: ">1000"]
    link: {
      label: "Show trend by hour" #or your label of choice
      url: "
      {% assign vis_config = '{
      \"x_axis_gridlines\":false,\"y_axis_gridlines\":true,\"show_view_names\":false,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":true,\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"limit_displayed_rows\":false,\"legend_position\":\"center\",\"point_style\":\"circle\",\"show_value_labels\":true,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"show_null_points\":true,\"interpolation\":\"linear\",\"y_axes\":[{\"label\":\"\",\"orientation\":\"left\",\"series\":[{\"axisId\":\"v_utilities.4_bar_dry_air\",\"id\":\"v_utilities.4_bar_dry_air\",\"name\":\"4 Bar Dry Air\"}],\"showLabels\":true,\"showValues\":true,\"unpinAxis\":true,\"tickDensity\":\"default\",\"tickDensityCustom\":5,\"type\":\"linear\"}],\"x_axis_zoom\":true,\"y_axis_zoom\":true,\"type\":\"looker_line\",\"defaults_version\":1
      }' %}
      {{ 4_bar_dry_air_drill_set_1._link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }
  measure: 4_bar_wet_air {
    label: "4 Bar Wet Air"
    type: average
    sql: ${id} ;;
    value_format: "0.00"
    filters: [order_id: ">1000"]
    link: {
      label: "Show trend by hour" #or your label of choice
      url: "{{ 4_bar_wet_air_drill_set_1._link }}"
    }
  }
  measure: 4_bar_dry_air_drill_set_1 {
    sql: 0 ;;
    drill_fields: [returned_time,4_bar_dry_air_2]
    hidden: yes
  }
  measure: 4_bar_wet_air_drill_set_1 {
    sql: 0 ;;
    drill_fields: [returned_time,4_bar_wet_air_2]
    hidden: yes
  }
  measure: 4_bar_wet_air_2 {
    hidden: yes
    label: "4 Bar Wet Air2"
    type: average
    sql: ${id} ;;
    value_format: "0.00"
    filters: [order_id: ">1000"]
    link: {
      label: "Show trend by minute" #or your label of choice
      url: "
      {% assign vis_config = '{
      \"x_axis_gridlines\":false,\"y_axis_gridlines\":true,\"show_view_names\":false,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":true,\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"limit_displayed_rows\":false,\"legend_position\":\"center\",\"point_style\":\"circle\",\"show_value_labels\":true,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"show_null_points\":true,\"interpolation\":\"linear\",\"y_axes\":[{\"label\":\"\",\"orientation\":\"left\",\"series\":[{\"axisId\":\"v_utilities.4_bar_dry_air\",\"id\":\"v_utilities.4_bar_dry_air\",\"name\":\"4 Bar Dry Air\"}],\"showLabels\":true,\"showValues\":true,\"unpinAxis\":true,\"tickDensity\":\"default\",\"tickDensityCustom\":5,\"type\":\"linear\"}],\"x_axis_zoom\":true,\"y_axis_zoom\":true,\"type\":\"looker_line\",\"defaults_version\":1
      }' %}
      {{ 4_bar_wet_air_drill_set_1._link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }
  measure: 4_bar_dry_air_2 {
    hidden: yes
    label: "4 Bar Dry Air 2"
    type: average
    sql: ${id} ;;
    value_format: "0.00"
    filters: [order_id: ">1000"]
    link: {
      label: "Show trend by minute" #or your label of choice
      url: "
      {% assign vis_config = '{
      \"x_axis_gridlines\":false,\"y_axis_gridlines\":true,\"show_view_names\":false,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":true,\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"limit_displayed_rows\":false,\"legend_position\":\"center\",\"point_style\":\"circle\",\"show_value_labels\":true,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"show_null_points\":true,\"interpolation\":\"linear\",\"y_axes\":[{\"label\":\"\",\"orientation\":\"left\",\"series\":[{\"axisId\":\"v_utilities.4_bar_dry_air\",\"id\":\"v_utilities.4_bar_dry_air\",\"name\":\"4 Bar Dry Air\"}],\"showLabels\":true,\"showValues\":true,\"unpinAxis\":true,\"tickDensity\":\"default\",\"tickDensityCustom\":5,\"type\":\"linear\"}],\"x_axis_zoom\":true,\"y_axis_zoom\":true,\"type\":\"looker_line\",\"defaults_version\":1
      }' %}
      {{ 4_bar_dry_air_drill_set_1._link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
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
