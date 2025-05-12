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

return subsequence($sorted, 1, 3)
