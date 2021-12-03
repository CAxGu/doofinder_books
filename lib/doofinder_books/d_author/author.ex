defmodule DoofinderBooks.DAuthor.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :birth, :date
    field :death, :date
    field :fullname, :string
    field :nationality, :string
    field :pseudonym, :string

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:fullname, :pseudonym, :birth, :death, :nationality])
    |> validate_required([:fullname, :birth])
  end
end
