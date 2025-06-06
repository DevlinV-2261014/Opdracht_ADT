declare function local:contains-name($doc as node(), $word as xs:string) {
  for $recipe in $doc//Recipe
  where contains(lower-case($recipe/Name), lower-case($word))
  return $recipe
};

let $xml := doc("eten.xml")
return local:contains-name($xml, 'SaLad')