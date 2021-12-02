defmodule DoofinderBooks.RelationsBooks.Rel_book_author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rel_books_authors" do
    field :author_id, :integer
    field :book_id, :integer
    timestamps()
  end

  @doc false
  def changeset(rel_book_author, attrs) do
    rel_book_author
    |> cast(attrs, [:book_id, :author_id])
    |> validate_required([:book_id, :author_id])
  end

  def create_author_rel_changeset(model, params \\ %{}) do
    model
    |> cast(params, [:book_id, :author_id])
    |> validate_required([:book_id, :author_id])
  end
end
