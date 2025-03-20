xquery version "3.1";

<results>{
  for $group in //*[n]
      group by $val := data($group/n)
      let $count := count($group)
      order by $val
  return
    <number>
      <value>{$val}</value>
      <count>{$count}</count>
    </number>
}</results>


(:
# Result

<?xml version="1.0" encoding="UTF-8"?>
<results>
   <number>
      <value>1</value>
      <count>1</count>
   </number>
   <number>
      <value>3</value>
      <count>3</count>
   </number>
   <number>
      <value>4</value>
      <count>3</count>
   </number>
   <number>
      <value>5</value>
      <count>1</count>
   </number>
   <number>
      <value>6</value>
      <count>1</count>
   </number>
   <number>
      <value>7</value>
      <count>1</count>
   </number>
</results>
:)