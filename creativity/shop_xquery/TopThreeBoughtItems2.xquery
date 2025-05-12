let $products :=
  for $product in /shop/products/product
  let $productid := $product/id
  let $quantityTotal := sum(
    /shop/baskets/basket/items/item[productid = $productid]/quantity/xs:integer(.)
  )
  return
    <product>
      <name>{ $product/name/text() }</name>
      <totalQuantity>{ $quantityTotal }</totalQuantity>
    </product>

let $sorted := 
  for $p in $products
  order by xs:integer($p/totalQuantity) descending
  return $p

let $top3 := subsequence($sorted, 1, 3)

return
  string-join(
    for $p at $pos in $top3
    return concat(
      $pos, ". ",
      $p/name/text(), " – purchased a total of ",
      $p/totalQuantity/text(), " times"
    ),
    "
"
  )
