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

  def form_createBook_changeset(model, params \\ %{}) do
    model
    |> cast(params, [:isbn, :title, :description, :publishing_date, :retired_date, :publishing, :language])
    |> cast_assoc(:authorsInfo, required: true, with: &Rel_book_author.create_author_rel_changeset/2)
    |> cast_assoc(:categoriesInfo, required: true, with: &Rel_book_category.create_category_rel_changeset/2)
    |> validate_required([:isbn, :title, :publishing_date, :publishing])
    |> put_idBook_author_data()
    |> put_idBook_category_data()
  end

  defp put_idBook_author_data(changeset) do
    if changeset.valid? do
      extras = %{provider: "books", uid: get_field(changeset, :id)}

      book_data =
        changeset
        |> get_field(:authorsInfo)
        |> Enum.map(&Map.merge(&1, extras))

      put_assoc(changeset, :authorsInfo, book_data)
    else
      changeset
    end
  end

  defp put_idBook_category_data(changeset) do
    if changeset.valid? do
      extras = %{provider: "books", uid: get_field(changeset, :id)}

      book_data =
        changeset
        |> get_field(:categoriesInfo)
        |> Enum.map(&Map.merge(&1, extras))

      put_assoc(changeset, :categoriesInfo, book_data)
    else
      changeset
    end
  end
end
