xquery version "3.1";

<results>{
  for $a in //a
  order by $a/n descending
  return <n>{ data($a/n) }</n>
}</results>

(:
//a selecteert alle a-elementen in het document (op elke diepte).
order by $a/n descending sorteert de gevonden a-elementen op basis van de waarde van hun <n>-kind in aflopende volgorde.
data($a/n) haalt de numerieke inhoud op van het <n>-element.
In de constructie <results>{ ... }</results> worden de resultaten als <n>...</n>-elementen in een <results>-element verpakt.

# Result
<?xml version="1.0" encoding="UTF-8"?>
<results>
   <n>5</n>
   <n>4</n>
   <n>3</n>
   <n>2</n>
</results

:)