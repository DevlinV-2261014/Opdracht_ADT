declare function local:resolve($id as xs:string) as xs:string {
  let $doc := doc("shop.xml")
  let $person := $doc//persons/person[id = $id]/name
  let $product := $doc//products/product[id = $id]/name
  return 
    if ($person) then $person
    else if ($product) then $product
    else ()
};

<baskets> {
for $basket in doc("shop.xml")//baskets/basket
return
  <basket>
    <personid>{local:resolve($basket/personid)}</personid>
    {
      for $item in $basket/items/item
      return
        <item>
          <productid>{local:resolve($item/productid)}</productid>
          <quantity>{$item/quantity}</quantity>
        </item>
    }
  </basket>
  }
  </baskets>
