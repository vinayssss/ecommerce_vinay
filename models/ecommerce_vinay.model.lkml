connection: "looker_private_demo"

# include all the views
include: "/views/**/*.view"

datagroup: ecommerce_vinay_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ecommerce_vinay_default_datagroup

explore: atom_inventory_items {
  join: products {
    type: left_outer
    sql_on: ${atom_inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: atom_ad_groups {
  join: campaigns {
    type: left_outer
    sql_on: ${atom_ad_groups.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }
}

explore: ad_groups {
  join: campaigns {
    type: left_outer
    sql_on: ${ad_groups.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }
}

explore: ad_events {
  join: keywords {
    type: left_outer
    sql_on: ${ad_events.keyword_id} = ${keywords.keyword_id} ;;
    relationship: many_to_one
  }
}

explore: atom_events {
  join: ad_events {
    type: left_outer
    sql_on: ${atom_events.ad_event_id} = ${ad_events.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${atom_events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: keywords {
    type: left_outer
    sql_on: ${ad_events.keyword_id} = ${keywords.keyword_id} ;;
    relationship: many_to_one
  }
}

explore: atom_campaigns {}

explore: atom_ad_events {
  join: keywords {
    type: left_outer
    sql_on: ${atom_ad_events.keyword_id} = ${keywords.keyword_id} ;;
    relationship: many_to_one
  }
}

explore: atom_order_items {
  join: users {
    type: left_outer
    sql_on: ${atom_order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${atom_order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: atom_users {}

explore: combined_orders_users {
  join: users {
    type: left_outer
    sql_on: ${combined_orders_users.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: atom_products {
  join: distribution_centers {
    type: left_outer
    sql_on: ${atom_products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: campaigns {}

explore: connection_reg_r3 {}

explore: distribution_centers {}

explore: kmeans_training {}

explore: events {
  join: ad_events {
    type: left_outer
    sql_on: ${events.ad_event_id} = ${ad_events.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: keywords {
    type: left_outer
    sql_on: ${ad_events.keyword_id} = ${keywords.keyword_id} ;;
    relationship: many_to_one
  }
}

explore: discounts {
  join: inventory_items {
    type: left_outer
    sql_on: ${discounts.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${discounts.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: keywords {}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  sql_always_having: ${count} < 50;;
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: products {
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: transaction_detail {
  join: transaction_detail__items {
    view_label: "Transaction Detail: Items"
    sql: LEFT JOIN UNNEST(${transaction_detail.items}) as transaction_detail__items ;;
    relationship: one_to_many
  }
}
