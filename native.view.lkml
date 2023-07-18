# If necessary, uncomment the line below to include explore_source.
# include: "ecommerce_vinay.model.lkml"

view: user_order_count {
  derived_table: {
    explore_source: order_items {
      column: full_name { field: users.full_name }
      column: count {}
    }
  }
  dimension: full_name {
    description: ""
  }
  dimension: count {
    description: ""
    type: number
  }
}
