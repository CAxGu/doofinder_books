defmodule DoofinderBooksWeb.BookController do
  use Timex
  use DoofinderBooksWeb, :controller

  alias DoofinderBooks.DBooks
  alias DoofinderBooks.DBooks.Book

  alias DoofinderBooks.DAuthor
  alias DoofinderBooks.DAuthor.Author

  alias DoofinderBooks.DCategory
  alias DoofinderBooks.DCategory.Category

  alias DoofinderBooks.RelationsBooks
  alias DoofinderBooks.RelationsBooks.Rel_book_author
  alias DoofinderBooks.RelationsBooks.Rel_book_category

  def index(conn, _params) do

    books = DBooks.list_books()
    authors = DAuthor.list_authors()
    categories = DCategory.list_categories()
    #concatAuthors = buildArrayAuthors(authors)
    #concatcategories = buildArrayCategories(categories

    render(conn, "index.html", books: books, authors: authors, categories: categories)
  end

  def new(conn, _params) do

    # Mapeamos autores y categorías para convertirlos en un select multiple
    authors = [" "]
    authors = listAuthors(DAuthor.list_authors())
    categories = [" "]
    categories = listCategories(DCategory.list_categories())

    changeset = DBooks.change_book(%Book{})
    render(conn, "new.html", changeset: changeset, authors: authors, categories: categories)
  end

  def create(conn, %{"book" => book_params}) do
    case DBooks.create_book(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Libro dado de alta correctamente.")
        |> redirect(to: Routes.book_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = DBooks.get_book!(id)
    render(conn, "show.html", book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = DBooks.get_book!(id)
    authors = [" "]
    authors = listAuthors(DAuthor.list_authors())
    categories = [" "]
    categories = listCategories(DCategory.list_categories())

    changeset = DBooks.change_book(book)
    render(conn, "edit.html", book: book, changeset: changeset, authors: authors, categories: categories)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = DBooks.get_book!(id)

    case DBooks.update_book(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Libro actualizado correctamente.")
        |> redirect(to: Routes.book_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = DBooks.get_book!(id)
    {:ok, _book} = DBooks.delete_book(book)

    conn
    |> put_flash(:info, "Libro borrado correctamente.")
    |> redirect(to: Routes.book_path(conn, :index))
  end

  def listAuthors(authors) do
    for author <- authors do author.fullname end
  end

  def listCategories(categories) do
    for category <- categories do category.name end
  end

  def getIdForAuthorSelected(author) do
    for category <- categories do category.name end
  end

  def getIdForCategorySelected(category) do
    for category <- categories do category.name end
  end

  @doc """
  def formatToExternalDate (book_params) do
    IO.inspect("EXTERNAL!!")
    IO.inspect(book_params)
    paramPublishingDate = book_params["publishing_date"]
    #TODO implementar un control de si llega esta fecha
    #paramRetiredDate = ""

    splitBy = "/"
    dateSplited = String.split(paramPublishingDate,splitBy)
    month = Enum.at(dateSplited, 0)
    day = Enum.at(dateSplited, 1)
    year = Enum.at(dateSplited, 2)
    resultPublishingDate = year<>"-"<>month<>"-"<>day
    book_params = %{book_params | "publishing_date" => resultPublishingDate}
    Map.replace(book_params, :publishing_date, resultPublishingDate)
  end

  def parseDateToString (date) do
    {:ok, fechita} = Timex.format(date, "{0M}/{D}/{YYYY}")
    IO.inspect(fechita)
    {:ok, result} = Timex.parse(fechita, "{0M}/{D}/{YYYY}")

    IO.inspect(result)
  end
  """
end
