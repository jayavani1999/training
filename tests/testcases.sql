select * from {{ ref("customers")}}
where number_of_orders > 2000012