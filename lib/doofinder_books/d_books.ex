defmodule DoofinderBooks.DBooks do
  @moduledoc """
  The DBooks context.
  """

  import Ecto.Query, warn: false
  alias DoofinderBooks.Repo
  alias Ecto.Multi

  alias DoofinderBooks.DBooks.Book
  alias DoofinderBooks.RelationsBooks.Rel_book_author
  alias DoofinderBooks.RelationsBooks.Rel_book_category

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Rel_book_author{}
    |> Rel_book_author.changeset(attrs)
    %Rel_book_category{}
    |> Rel_book_category.changeset(attrs)
    %Book{}
    |> Book.changeset(attrs)
    #|> Repo.insert()
  end

  def create_book_with_relations(attrs \\ %{}) do
    Multi.new()
    |> Multi.insert(:book, Book.changeset(%Book{}, attrs))
    |> Multi.run(:rel_book_author, fn repo, %{book: book} ->
      book_id = book.id
      author_id = attrs["author_id"]
      Repo.insert(Rel_book_author.changeset(%Rel_book_author{}, %{author_id: author_id ,book_id: book_id}))
    end)
    |> Multi.run(:rel_book_category, fn repo, %{rel_book_author: rel_book_author} ->
      book_id = rel_book_author.book_id
      category_id = attrs["category_id"]
      Repo.insert(Rel_book_category.changeset(%Rel_book_category{}, %{category_id: category_id ,book_id: book_id}))
    end)
    |> Repo.transaction()
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}

  """
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end
end
