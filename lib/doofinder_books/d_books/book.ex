defmodule DoofinderBooks.DBooks.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :authors, :string
    field :categories, :string
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
    |> cast(attrs, [:isbn, :title, :authors, :description, :publishing_date, :retired_date, :categories, :publishing, :language])
    |> validate_required([:isbn, :title, :authors, :description, :publishing_date, :categories, :publishing, :language])
  end
end
