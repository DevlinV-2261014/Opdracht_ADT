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
  <sharedPurchase>
    <person1>{ $p1/name/text() }</person1>
    <person2>{ $p2/name/text() }</person2>
    <sharedItems>
      {
        for $pid in distinct-values($common)
        let $pname := /shop/products/product[id = $pid]/name
        return <item>{ $pname/text() }</item>
      }
    </sharedItems>
  </sharedPurchase>
