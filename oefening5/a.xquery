declare function local:resolve($id as xs:string) as xs:string? {
  let $doc := doc("shop.xml")
  let $person := $doc//persons/person[id = $id]/name
  let $product := $doc//products/product[id = $id]/name
  return 
    if ($person) then $person
    else if ($product) then $product
    else ()
};
local:resolve("101")
