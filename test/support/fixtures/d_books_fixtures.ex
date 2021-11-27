defmodule DoofinderBooks.DBooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DoofinderBooks.DBooks` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        authors: "some authors",
        categories: "some categories",
        description: "some description",
        isbn: "some isbn",
        language: "some language",
        publishing: "some publishing",
        publishing_date: ~D[2021-11-26],
        retired_date: ~D[2021-11-26],
        title: "some title"
      })
      |> DoofinderBooks.DBooks.create_book()

    book
  end
end
