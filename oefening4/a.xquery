xquery version "3.1";
for $x in //*[n]
for $y in $x/descendant::*[n]
return
  <pair>
    <x>{ data($x/n) }</x>
    <y>{ data($y/n) }</y>
  </pair>
