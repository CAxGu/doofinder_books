defmodule DoofinderBooks.RelationsBooks do
  import Ecto.Query, warn: false
  alias DoofinderBooks.Repo
  alias Ecto.Multi
  alias DoofinderBooks.RelationsBooks.Rel_book_author
  alias DoofinderBooks.RelationsBooks.Rel_book_category

  # Bloque functions rel_book_authors
  def list_rel_books_authors do
    Repo.all(Rel_book_author)
  end

  def get_rel_book_author!(id), do: Repo.get!(Rel_book_author, id)

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


  def update_rel_book_author(%Rel_book_author{} = rel_book_author, attrs) do
    rel_book_author
    |> Rel_book_author.changeset(attrs)
    |> Repo.update()
  end

  def delete_rel_book_author(%Rel_book_author{} = rel_book_author) do
    Repo.delete(rel_book_author)
  end

  def change_rel_book_author(%Rel_book_author{} = rel_book_author, attrs \\ %{}) do
    Rel_book_author.changeset(rel_book_author, attrs)
  end






  @doc """





  """

  # Bloque functions rel_book_categories
  def list_rel_books_categorys do
    Repo.all(Rel_book_category)
  end

  def get_rel_book_category!(id), do: Repo.get!(Rel_book_category, id)

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

  def update_rel_book_category(%Rel_book_category{} = rel_book_category, attrs) do
    rel_book_category
    |> Rel_book_category.changeset(attrs)
    |> Repo.update()
  end

  def delete_rel_book_category(%Rel_book_category{} = rel_book_category) do
    Repo.delete(rel_book_category)
  end

  def change_rel_book_category(%Rel_book_category{} = rel_book_category, attrs \\ %{}) do
    Rel_book_category.changeset(rel_book_category, attrs)
  end
end
