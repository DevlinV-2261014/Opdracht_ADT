for $recipe in //Recipe
where count($recipe/Ingredients/Ingredient) = 3
return $recipe
