xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";

let $reports :=
  for $prod in /shop/products/product
  let $pid    := data($prod/id)
  let $unit   := number($prod/price)
  let $qty    := sum(
                  for $it in /shop/baskets/basket/items/item
                  where data($it/productid) = $pid
                  return number(data($it/quantity))
                )
  let $rev    := $unit * $qty
  let $buyers := string-join(
                  for $bid in distinct-values(
                    /shop/baskets/basket[items/item/productid = $pid]/personid
                  )
                  let $p := /shop/persons/person[id = $bid]
                  return data($p/name)
                , ", ")
  where $qty > 0
  return
    concat(
      data($prod/name), ": verkocht ", $qty,
      " stuks, omzet €", format-number($rev, '0.00'),
      ", kopers: ", $buyers
    )

return
string-join($reports, "
")
