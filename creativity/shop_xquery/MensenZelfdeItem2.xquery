for $p1 in /shop/persons/person
for $p2 in /shop/persons/person
where $p1/id < $p2/id
let $id1 := $p1/id
let $id2 := $p2/id

let $products1 := /shop/baskets/basket[personid = $id1]/items/item/productid
let $products2 := /shop/baskets/basket[personid = $id2]/items/item/productid

let $common := for $pid in $products1
               where $pid = $products2
               return $pid

where count($common) > 0

return
  let $name1 := $p1/name/text()
  let $name2 := $p2/name/text()
  let $items := for $pid in distinct-values($common)
                let $pname := /shop/products/product[id = $pid]/name/text()
                return $pname
  return
    concat(
      $name1, " and ", $name2,
      " hebben beiden volgende item(s) gekocht: ",
      string-join($items, ", "),
      ".
      "
    )
