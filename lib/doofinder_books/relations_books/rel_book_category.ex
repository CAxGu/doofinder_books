defmodule DoofinderBooks.RelationsBooks.Rel_book_category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rel_books_categories" do
    field :book_id, :integer
    field :category_id, :integer

    timestamps()
  end

  @doc false
  def changeset(rel_book_category, attrs) do
    rel_book_category
    |> cast(attrs, [:book_id, :category_id])
    |> validate_required([:book_id, :category_id])
  end
end
