for $t in distinct-values(//Tag)
let $recipes := //Recipe[Tags/Tag = $t]
return <Group tag="{$t}" count="{count($recipes)}"/>
