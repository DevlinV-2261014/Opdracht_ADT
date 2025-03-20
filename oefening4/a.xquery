xquery version "3.1";
for $x in //*[n]
for $y in $x/descendant::*[n]
return
  <pair>
    <x>{ data($x/n) }</x>
    <y>{ data($y/n) }</y>
  </pair>
(: 
# Result
<?xml version="1.0" encoding="UTF-8"?>
<pair>
   <x>1</x>
   <y>2</y>
</pair>
<pair>
   <x>1</x>
   <y>8</y>
</pair>
<pair>
   <x>1</x>
   <y>9</y>
</pair>
<pair>
   <x>1</x>
   <y>3</y>
</pair>
<pair>
   <x>1</x>
   <y>7</y>
</pair>
<pair>
   <x>1</x>
   <y>9</y>
</pair>
<pair>
   <x>1</x>
   <y>4</y>
</pair>
<pair>
   <x>1</x>
   <y>8</y>
</pair>
<pair>
   <x>1</x>
   <y>9</y>
</pair>
<pair>
   <x>1</x>
   <y>8</y>
</pair>
<pair>
   <x>1</x>
   <y>5</y>
</pair>
<pair>
   <x>1</x>
   <y>8</y>
</pair>
<pair>
   <x>1</x>
   <y>9</y>
</pair>
<pair>
   <x>2</x>
   <y>8</y>
</pair>
<pair>
   <x>2</x>
   <y>9</y>
</pair>
<pair>
   <x>3</x>
   <y>7</y>
</pair>
<pair>
   <x>3</x>
   <y>9</y>
</pair>
<pair>
   <x>4</x>
   <y>8</y>
</pair>
<pair>
   <x>4</x>
   <y>9</y>
</pair>
<pair>
   <x>8</x>
   <y>5</y>
</pair>
<pair>
   <x>8</x>
   <y>8</y>
</pair>
<pair>
   <x>8</x>
   <y>9</y>
</pair>
<pair>
   <x>5</x>
   <y>8</y>
</pair>
<pair>
   <x>5</x>
   <y>9</y>
</pair>

:)