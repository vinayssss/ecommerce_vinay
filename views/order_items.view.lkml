view: order_items {
  sql_table_name: `ecomm.order_items`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    #hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
   # hidden: yes
    sql: ${TABLE}.order_id ;;
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
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: no
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
     drill_fields: [detail*]
  }

  measure:total_sale{
  type:sum
  sql:${TABLE}.sale_price;;
  value_format_name: usd
  }
  measure: total_order_amount {
    type: sum
    sql: ${sale_price} ;;
    value_format: "0.00"
    html:
    <ul>
      <li> value: {{ value }} </li>
      <li> rendered_value: {{ rendered_value }} </li>
      <li> linked_value: {{ linked_value }} </li>
      <li> link: {{ link }} </li>
      <li> model: {{ _model._name }} </li>
      <li> view: {{ _view._name }} </li>
      <li> explore: {{ _explore._name }} </li>
      <li> field: {{ _field._name }} </li>
      <li> dialect: {{ _dialect._name }} </li>
      <li> access filter: {{ _access_filters['-null'] }} </li>
      <li> user attribute: {{ _user_attributes['region'] }} </li>
      <li> query timezone: {{ _query._query_timezone }} </li>
      <li> filters: {{ _filters['order_items.total_order_amount'] }} </li>
    </ul> ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
