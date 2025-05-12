for $person in /shop/persons/person
let $pid := $person/id
let $basket := /shop/baskets/basket[personid = $pid]
let $items := $basket/items/item
let $total := sum(
  for $item in $items
  let $product := /shop/products/product[id = $item/productid]
  return xs:decimal($item/quantity) * xs:decimal($product/price)
)
order by $total descending
return
  concat(
    $person/name/text(), " – €", format-number($total, '#.00'), " 
    "
  )
