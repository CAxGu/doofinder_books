defmodule DoofinderBooks.DBooks.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :description, :string
    field :isbn, :string
    field :language, :string
    field :publishing, :string
    field :publishing_date, :date
    field :retired_date, :date
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:isbn, :title, :description, :publishing_date, :retired_date, :publishing, :language])
    |> validate_required([:isbn, :title, :publishing_date, :publishing])
  end
end
