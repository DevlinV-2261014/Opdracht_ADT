(: Bereken recursief de som van de n-waarden in de subboom van $t,
   waarbij we de n-waarde van de huidige node uitsluiten.
   We nemen aan dat de kinderen die een waarde bevatten altijd 
   geen n-element zijn (want het eerste kind n hoort bij de huidige node). :)
declare function local:depth($t as element()) as xs:integer {
  let $childDepths := for $child in $t/* return local:depth($child)
  return 1 + (if (empty($childDepths)) then 0 else max($childDepths))
};


declare function local:sum($t as element()) as xs:integer {
  sum(
    for $child in $t/*[local-name() ne 'n']
    return ($child/n/xs:integer(.)) + local:sum($child)
  )
};

(: Transformatie: kopieer de boom en voeg bij elke a-node een s-node toe :)
declare function local:transform($t as node()) as node() {
  if ($t instance of element()) then
    element {node-name($t)} {
      for $child in $t/node() return local:transform($child),
      if (local-name($t) = "a")
      then element s { local:sum($t) }
      else ()
    }
  else
    $t
};

(: Testaanroep :)
local:transform(doc('../oefening3/root.xml')/r)

(:
<?xml version="1.0" encoding="UTF-8"?>
<r>
   <n>1</n>
   <b>
      <n>5</n>
      <c>
         <n>3</n>
      </c>
      <d>
         <n>4</n>
      </d>
   </b>
   <b>
      <n>6</n>
      <d>
         <n>4</n>
      </d>
      <c>
         <n>3</n>
      </c>
      <!-- Wrong order, this <b> is ignored -->
   </b>
   <b>
      <n>7</n>
      <c>
         <n>3</n>
      </c>
      <d>
         <n>4</n>
      </d>
   </b>
</r>
:)
