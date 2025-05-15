declare function local:update-node(
  $node as node(),
  $old as xs:string,
  $new as xs:string
) as node() {
  typeswitch($node)
    case element(Recipe) return local:process-recipe($node, $old, $new)
    case element() return
      element {node-name($node)} {
        for $child in $node/node()
        return local:update-node($child, $old, $new)
      }
    default return $node
};

declare function local:pascal-case($str as xs:string) as xs:string {
  string-join(
    for $word in tokenize($str, '\s+')
    return
      concat(
        upper-case(substring($word, 1, 1)),
        lower-case(substring($word, 2))
      ),
    ' '
  )
};

declare function local:replace-name(
$title as element(Name), 
$old as xs:string, 
$new as xs:string) as element(Name){
    element Name{
        replace($title/text(), $old, local:pascal-case($new), "i") (: i flag = case-insensitive :)
    }
};

declare function local:replace-ingredient(
  $ingredient as element(Ingredient), 
  $old as xs:string, 
  $new as xs:string
) as element(Ingredient) {
  element Ingredient {
    replace($ingredient/text(), $old, $new)
  }
};

declare function local:replace-step(
  $step as element(Step), 
  $old as xs:string, 
  $new as xs:string
) as element(Step) {
  element Step {
    replace($step/text(), $old, $new)
  }
};

declare function local:process-recipe(
  $recipe as element(Recipe), 
  $old as xs:string, 
  $new as xs:string
) as element(Recipe) {
  element Recipe {
    local:replace-name($recipe/Name, $old, $new),
    element Ingredients {
      for $ing in $recipe/Ingredients/Ingredient
      return local:replace-ingredient($ing, $old, $new)
    },
    element Steps {
      for $step in $recipe/Steps/Step
      return local:replace-step($step, $old, $new)
    },
    $recipe/PrepTime,
    $recipe/CookTime,
    $recipe/Servings,
    $recipe/Tags,
    $recipe/Calories
  }
};

let $doc := doc("eten.xml")/Meals
return local:update-node($doc, "spinach", "red cabbage")
