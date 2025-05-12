(:p5Inventory-4Advanced:)
xquery version "3.1";

let $person := /shop/persons/person[id = 5]
return
  concat(
    data($person/name),
    ' met koperID = ', data($person/id),
    ', koopt ',
    string-join(
      for $item in /shop/baskets/basket[personid = 5]/items/item[quantity >= 4]
      let $prod  := /shop/products/product[id = $item/productid]
      let $unit  := number($prod/price)
      let $qty   := number($item/quantity)
      let $total := $unit * $qty
      return
        concat(
          $qty, 'x ', data($prod/name),
          ' (€', format-number($unit, '0'), ' per stuk)',
          ', totaal = €', format-number($total, '0.00')
        ),
      ', '
    ),
    '.'
  )
