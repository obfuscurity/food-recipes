# Constribution guide
Please take a moment to review this document in order to make the contribution process easy and effective for everyone involved.

## Steps
* Add the recipes in the corresponding folders inside this repository. (For example breakfasts, desserts, etc.)
  * Name the recipe files in PascalCase (For example FishTacos.md or ThaiRedCurryChicken.md)
* Add the recipes in the [README.md under section Index](README.md#index).
  * Either:
    * Do it manually, as `* [Your Recipe File Name With Spaces Between Words Here](https://github.com/obfuscurity/food-recipes/blob/master/<food-category>/<Recipe File>.md)`
      * (For example: `* [Fish Tacos](https://github.com/obfuscurity/food-recipes/blob/master/entrees/FishTacos.md)`)
    * Or use the automation script to add all of your recipes to the index at once, see the section below

## Automated adding to the Recipe index
The automation script is `gen.exs`, which is an elixir script file.
Running this requires having [elixir installed](https://elixir-lang.org/install.html).

After which you can simply run
```sh
elixir gen.exs
```

And all the recipe file links will be written to README.md

Thank you for reading :D
