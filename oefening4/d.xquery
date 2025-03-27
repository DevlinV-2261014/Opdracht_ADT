declare function local:depth($t as element()) as xs:integer {
  let $childDepths := for $child in $t/* return local:depth($child)
  return 1 + (if (empty($childDepths)) then 0 else max($childDepths))
};

local:depth(doc('../oefening3/root.xml')/r)


(:

:)