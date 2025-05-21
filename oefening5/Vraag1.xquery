declare function local:resolve($id as xs:string) as xs:string {
  let $doc := doc("shop.xml")
  let $person := $doc//persons/person[id = $id]/name
  let $product := $doc//products/product[id = $id]/name
  return 
    if ($person) then $person
    else if ($product) then $product
    else ()
};

string-join((
  local:resolve("1"),
  local:resolve("2"),
  local:resolve("101"),
  local:resolve("102"),
  local:resolve("103")
), codepoints-to-string(10))
