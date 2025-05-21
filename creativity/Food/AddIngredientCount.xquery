for $r in //Recipe
return
  <Recipe>
    {$r/*}
    <IngredientCount>{count($r/Ingredients/Ingredient)}</IngredientCount>
  </Recipe>
