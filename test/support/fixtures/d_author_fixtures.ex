defmodule DoofinderBooks.DAuthorFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DoofinderBooks.DAuthor` context.
  """

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        birth: ~D[2021-11-28],
        death: ~D[2021-11-28],
        fullname: "some fullname",
        nationality: "some nationality",
        pseudonym: "some pseudonym"
      })
      |> DoofinderBooks.DAuthor.create_author()

    author
  end
end
