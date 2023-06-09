view: users {
  sql_table_name: `ecomm.users`
    ;;
  drill_fields: [id]

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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    order_by_field: subject_ordering
  }

  # dimension: first_name_for_sort {
  #   type: string
  #   sql: CASE ${first_name}
  #       WHEN 'B' THEN '1 B'
  #       WHEN 'A' THEN '2 A'
  #       WHEN 'C' THEN '3 C'
  #     END ;;
  #   label: "First_namess"
  #   html: {{ value | remove_first: "1 " | remove_first: "2 " | remove_first: "3 " }} ;;
  #   }
  dimension: subject_ordering {
    type: number
    sql:
      CASE
        WHEN ${first_name} = 'A' THEN 1
        WHEN ${first_name} = 'B' THEN 2
        WHEN ${first_name} = 'C' THEN 3
        ELSE 4
      END ;;
    hidden: yes
    description: "This dimension is used to force sort the subject dimension."
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    order_by_field: subject_orderings
  }
  dimension: subject_orderings {
    type: number
    sql:
      CASE
        WHEN ${state} = 'A' THEN 1
        WHEN ${state} = 'B' THEN 2
        WHEN ${state} = 'C' THEN 3
        ELSE 4
      END ;;
    hidden: yes
    description: "This dimension is used to force sort the subject dimension."
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
  dimension: full_name {
    type: string
    sql: concat(${first_name}," ",${last_name}) ;;
  }

  dimension: artist_name {
    sql: ${TABLE}.first_name;;
    link: {
      label: "Google"
      url: "https://www.google.com/search?q={{ 10000 }}"
      icon_url: "https://google.com/favicon.ico"
    }
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      atom_events.count,
      atom_order_items.count,
      combined_orders_users.count,
      events.count,
      order_items.count
    ]
  }
}
