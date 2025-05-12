xquery version "3.1";

string-join(
  for $person in /shop/persons/person
  let $items := /shop/baskets/basket[personid = $person/id]/items/item
  (: verzamel alle aankopen > 100 van deze persoon :)
  let $values :=
    for $item in $items
    let $prod  := /shop/products/product[id = $item/productid]
    let $unit  := number($prod/price)
    let $qty   := number($item/quantity)
    let $total := $unit * $qty
    where $total > 100
    return
      concat(
        data($prod/name),
        ' (unit-price=€', format-number($unit, '0.00'),
        ', qty=',        $qty,
        ', totaal=€',    format-number($total, '0.00'),
        ')'
      )
  (: sommeer die totaalsommen :)
  let $sumTotal :=
    sum(
      for $item in $items
      let $prod  := /shop/products/product[id = $item/productid]
      let $unit  := number($prod/price)
      let $qty   := number($item/quantity)
      let $total := $unit * $qty
      where $total > 100
      return $total
    )
  where exists($values)
  (: maak de output-string :)
  return
    concat(
      data($person/name),
      ' (id=', data($person/id), ') heeft gekocht: ',
      string-join($values, ', '),
      ' - totaal uitgegeven = €', format-number($sumTotal, '0.00')
    )
, '&#10;')
