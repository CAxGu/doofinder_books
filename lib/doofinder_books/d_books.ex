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
  alias DoofinderBooks.DAuthor.Author
  alias DoofinderBooks.DCategory.Category

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
  Método que recupera TODA la información asociada a cada libro dado de alta
"""
  def list_all_books_info do
    query = from c2 in "rel_books_categories",
          join: b in "books",
          join: cat in "categories",
          join: ra in "rel_books_authors",
          join: aut in "authors",
          on: c2.book_id == b.id,
          on: c2.category_id == cat.id,
          on: ra.book_id == b.id,
          on: ra.author_id == aut.id,
          select: %{:id => b.id,:description => b.description,:isbn => b.isbn,:language => b.language,:publishing => b.publishing,:publishing_date => b.publishing_date,:retired_date => b.retired_date,:category_id => cat.name,:author_id => aut.fullname,:title => b.title,:inserted_at => b.inserted_at,:updated_at => b.updated_at}

    Repo.all(query)
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
    Metodo que nos devolverá toda la información del libro con el solicitado.
    Recuperará en esta ocasión el category.id y authors.id en lugar de su category.name y authors.fullname, para poder tratar los datos desde el form edit
   """
  def get_all_book_info!(id) do
    id_book=String.to_integer(id)
    query = from c2 in "rel_books_categories",
          join: b in "books",
          join: cat in "categories",
          join: ra in "rel_books_authors",
          join: aut in "authors",
          on: c2.book_id == b.id,
          on: c2.category_id == cat.id,
          on: ra.book_id == b.id,
          on: ra.author_id == aut.id,
          where: b.id == ^id_book,
          select: %{:id => b.id,:description => b.description,:isbn => b.isbn,:language => b.language,:publishing => b.publishing,:publishing_date => b.publishing_date,:retired_date => b.retired_date,:category_id => cat.id,:author_id => aut.id,:title => b.title,:inserted_at => b.inserted_at,:updated_at => b.updated_at}

    Repo.all(query)
  end

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Funcion que permite realizar de manera escalonada el creado de datos de las tablas 'books',
  'rel_book_authors' y 'rel_book_categories.

  Dado que las tablas comparten FOREIGN_KEYS , se precisa crear primero el registro del libro y finalmente las relaciones asociadas
  """
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

  def update_book_and_relations(%Book{} = book, attrs, %Rel_book_author{} = rel_book_author, %Rel_book_category{} = rel_book_category) do
    Multi.new()
    |> Multi.update(:book_, book |> Book.changeset(attrs))
    |> Multi.update(:rel_book_author_, rel_book_author |> Rel_book_author.changeset(attrs))
    |> Multi.update(:rel_book_category_, rel_book_category |> Rel_book_category.changeset(attrs))
    |> Repo.transaction()
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
  Funcion que permite realizar de manera escalonada el borrado de las tablas 'books',
  'rel_book_authors' y 'rel_book_categories.

  Dado que las tablas comparten FOREIGN_KEYS , se eliminan primero las relaciones y finalmente el libro asociado
  """
  def delete_book_and_relations(%Book{} = book) do
    book_id = book.id
    queryableBook = from(b in Book, where: b.id == ^book_id)
    queryableRelAuthors = from(ra in Rel_book_author, where: ra.book_id == ^book_id)
    queryableRelCategories = from(rc in Rel_book_category, where: rc.book_id == ^book_id)
    Multi.new()
    |> Multi.delete_all(:delete_relAuthors, queryableRelAuthors)
    |> Multi.delete_all(:delete_relCategories, queryableRelCategories)
    |> Multi.delete_all(:delete_book, queryableBook)
    |> Repo.transaction()
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
