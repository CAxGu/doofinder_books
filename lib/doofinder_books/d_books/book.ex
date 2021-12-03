defmodule DoofinderBooks.DBooks.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias DoofinderBooks.RelationsBooks.Rel_book_author
  alias DoofinderBooks.RelationsBooks.Rel_book_category

  schema "books" do
    field :description, :string
    field :isbn, :string
    field :language, :string
    field :publishing, :string
    field :publishing_date, :date
    field :retired_date, :date
    field :title, :string
    has_many :authorsinfo, Rel_book_author
    has_many :categoriesinfo, Rel_book_category

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:isbn, :title, :description, :publishing_date, :retired_date, :publishing, :language])
    |> validate_required([:isbn, :title, :publishing_date, :publishing])
  end

  def form_createBook_changeset(book, attrs) do
    book
    |> cast(attrs, [:isbn, :title, :description, :publishing_date, :retired_date, :publishing, :language])
    |> cast_assoc(:authorsinfo, required: true, with: &Rel_book_author.create_author_rel_changeset/2)
    |> cast_assoc(:categoriesinfo, required: true, with: &Rel_book_category.create_category_rel_changeset/2)
    |> validate_required([:isbn, :title, :publishing_date, :publishing])
  end
end
