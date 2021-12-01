defmodule DoofinderBooks.DPruebasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DoofinderBooks.DPruebas` context.
  """

  @doc """
  Generate a prueba.
  """
  def prueba_fixture(attrs \\ %{}) do
    {:ok, prueba} =
      attrs
      |> Enum.into(%{
        holaquetal: []
      })
      |> DoofinderBooks.DPruebas.create_prueba()

    prueba
  end
end
