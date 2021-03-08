defmodule(Readme) do
  def write(recipes) do
    File.open!("./README.md", [:write])
    |> IO.binwrite(document(recipes))
    |> File.close()
  end

  def document(recipes) do
    content_header = File.read!("./README_header.md")
    content_index = recipe_group_index(recipes)
    content_body = recipe_listing(recipes)

    Enum.join([content_header, content_index, content_body], "\n")
  end

  def recipe_group_index(recipes) do
    recipes
    |> Enum.map(fn {recipe_group, _recipe_files} ->
      "* [" <> recipe_group <> "](" <> "#" <> String.downcase(recipe_group) <> ")"
    end)
    |> (&("These are the kinds of recipes:\n\n" <> Enum.join(&1, "\n") <> "\n")).()
  end

  def recipe_listing(recipes) do
    recipes
    |> Enum.map(fn {group, recipe_files} ->
      Enum.join(
        [
          Readme.header_for_recipe_group(group),
          Readme.rows_for_recipe_files(group, recipe_files),
          ""
        ],
        "\n"
      )
    end)
  end

  def header_for_recipe_group(recipe_group) do
    "## " <> Macro.camelize(recipe_group) <> "\n"
  end

  def rows_for_recipe_files(recipe_group, recipe_files) do
    recipe_files
    |> Enum.map(
      &("* [" <>
          Readme.row_link_name(&1) <>
          "](https://github.com/obfuscurity/food-recipes/blob/master/" <>
          recipe_group <> "/" <> &1 <> ")\n")
    )
  end

  def row_link_name(filename) do
    filename
    |> String.slice(0..-4)
    |> StringEx.space_words_on_uppercase()
  end
end

defmodule(StringEx) do
  def space_words_on_uppercase(text) do
    Enum.join(
      tl(String.split(text, ~r{(?=[A-Z])}, trim: true, include_captures: true))
      |> StringEx.map("", " "),
      ""
    )
  end

  def map(collection, find, substitute) do
    Enum.map(collection, fn word ->
      if word == find do
        substitute
      else
        word
      end
    end)
  end
end

File.ls!("./")
|> Enum.reject(fn x -> String.starts_with?(x, ".") end)
|> Enum.reject(fn x -> not File.dir?(x) end)
|> Enum.map(fn recipe_folder ->
  %{
    recipe_folder =>
      File.ls!(recipe_folder)
      |> Enum.reject(fn x -> String.ends_with?(x, ".gitignore") end)
  }
end)
|> Enum.reduce(%{}, fn x, acc -> Map.merge(x, acc) end)
|> Readme.write()
