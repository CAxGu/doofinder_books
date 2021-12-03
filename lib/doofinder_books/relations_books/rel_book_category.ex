defmodule DoofinderBooks.RelationsBooks.Rel_book_category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rel_books_categories" do
    field :category_id, :integer
    field :book_id, :integer
    timestamps()
  end

  @doc false
  def changeset(rel_book_category, attrs) do
    rel_book_category
    |> cast(attrs, [:book_id, :category_id])
    |> validate_required([:book_id, :category_id])
  end

  def create_category_rel_changeset(model, params \\ %{}) do
    model
    |> cast(params, [:book_id, :category_id])
    |> validate_required([:category_id])
  end
end
