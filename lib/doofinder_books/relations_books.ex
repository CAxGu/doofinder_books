defmodule DoofinderBooks.RelationsBooks do
  import Ecto.Query, warn: false
  alias DoofinderBooks.Repo
  alias DoofinderBooks.RelationsBooks.Rel_book_author
  alias DoofinderBooks.RelationsBooks.Rel_book_category

  # Bloque functions rel_book_authors

  @doc """
  Retorna una lista de todas las realaciones book - author en BBDD
  """
  def list_rel_books_authors do
    Repo.all(Rel_book_author)
  end

  @doc """
  Retorna el rel_book_author asociado al id de la relacion
  """
  def get_rel_book_author!(id), do: Repo.get!(Rel_book_author, id)


  @doc """
  Retorna el rel_book_author asociado al id del libro asociado
  """
  def get_by_rel_book_author!(idBook) do
    Repo.get_by!(Rel_book_author, [book_id: idBook])
  end

  @doc """
  def create_rel_book_author(bookId, timeInsert, authors \\ %{}) do
    maps =
      Enum.map(authors, fn(authorId) ->
        parsedId = String.to_integer(authorId)
        %Rel_book_author{author_id: parsedId, book_id: bookId, inserted_at: timeInsert, updated_at: timeInsert}
      end)
    Repo.insert_all(Rel_book_author, maps)
  end
  """
  def create_rel_book_author(attrs \\ %{}) do
    %Rel_book_author{}
    |> Rel_book_author.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Actualización de todos los  schemas relacionados con book: rel_book_author y rel_book_category
  """
  def update_rel_book_author(%Rel_book_author{} = rel_book_author, attrs) do
    rel_book_author
    |> Rel_book_author.changeset(attrs)
    |> Repo.update()
  end

   @doc """
  Borrado de relacion en la tabla rel_book_authors del map rel_book_author facilitado
  """
  def delete_rel_book_author(%Rel_book_author{} = rel_book_author) do
    Repo.delete(rel_book_author)
  end

  @doc """
  Retorna el changeset de rel_book_author
  """
  def change_rel_book_author(%Rel_book_author{} = rel_book_author, attrs \\ %{}) do
    Rel_book_author.changeset(rel_book_author, attrs)
  end






  # Bloque functions rel_book_categories

   @doc """
  Retorna una lista de todas las realaciones book - category en BBDD
  """
  def list_rel_books_categorys do
    Repo.all(Rel_book_category)
  end

  @doc """
  Retorna el rel_book_category asociado al id de la relacion
  """
  def get_rel_book_category!(id), do: Repo.get!(Rel_book_category, id)


  @doc """
  Retorna el rel_book_category asociado al id del libro asociado
  """
  def get_by_rel_book_category!(idBook) do
    Repo.get_by!(Rel_book_category, [book_id: idBook])
  end



  @doc """
  def create_rel_book_category(categories \\ %{}, bookId, timeInsert) do
    #%Rel_book_category{}
    #|> Rel_book_category.changeset(attrs)
    #|> Repo.insert()
    maps =
      Enum.map(categories, fn(categoryId) ->
        parsedId = String.to_integer(categoryId)
        %{category_id: parsedId, book_id: bookId, inserted_at: timeInsert, updated_at: timeInsert}
      end)
    Repo.insert_all(Rel_book_category, maps)
  end
  """
  def create_rel_book_category(attrs \\ %{}) do
    %Rel_book_category{}
    |> Rel_book_category.changeset(attrs)
    |> Repo.insert()
  end


 @doc """
  Actualización de todos los  schemas relacionados con book: rel_book_author y rel_book_category
  """
  def update_rel_book_category(%Rel_book_category{} = rel_book_category, attrs) do
    rel_book_category
    |> Rel_book_category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Borrado de relacion en la tabla rel_book_categories del map rel_book_category facilitado
  """
  def delete_rel_book_category(%Rel_book_category{} = rel_book_category) do
    Repo.delete(rel_book_category)
  end

  @doc """
  Retorna el changeset de rel_book_category
  """
  def change_rel_book_category(%Rel_book_category{} = rel_book_category, attrs \\ %{}) do
    Rel_book_category.changeset(rel_book_category, attrs)
  end
end
