defmodule DoofinderBooks.DCategoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DoofinderBooks.DCategory` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> DoofinderBooks.DCategory.create_category()

    category
  end
end
