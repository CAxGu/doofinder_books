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

    #rel_book_author=%{"rel_book_author" => %{
    #  "author_id": 1,
    #  "book_id": 1
    #}}

    #"categories" => ["3"],

    #book_prueba = %{"description" => "lorem ipsun y esto y lo otro cosas y mas cosas blablabla", "isbn" => "A4555454554585835", "language" => "ESP", "publishing" => "CAXGU", "publishing_date" => "2021-11-09", "retired_date" => "", "title" => "No se que hago con mi vida"}

    render(conn, "index.html", books: books, authors: authors, categories: categories)
  end

  def new(conn, _params) do
    # Mapeamos autores y categorías para convertirlos en un select multiple
    # Añadimos un campo vacío a los array para obligar al usuario a seleccionar 1 autor y 1 categoría
    authors = [{:"", ""} | DAuthor.list_AllIdNameAuthors()]
    categories = [{:"", ""} | DCategory.list_AllIdNameCategories()]
    changeset = DBooks.change_book(%Book{})
    render(conn, "new.html", changeset: changeset, authors: authors, categories: categories)
  end


  #def create(conn, %{"book" => book_params}) do
  #  createBook(conn, book_params, book_params["author_id"])
  #end


  def create(conn, %{"book" => book_params}) do
    case DBooks.create_book_with_relations(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Libro dado de alta correctamente.")
        |> redirect(to: Routes.book_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        authorList = [{:"", ""} | DAuthor.list_AllIdNameAuthors()]
        categoryList = [{:"", ""} | DCategory.list_AllIdNameCategories()]
        render(conn, "new.html", changeset: changeset, authors: authorList, categories: categoryList)
    end
  end

@doc """

RelationsBooks.create_rel_book_author(%{"author_id" => authors, "book_id" =>  book.id})
{:ok, _rel_book_author} ->
      conn
      |> put_flash(:info, "Libro dado de alta correctamente.")
      |> redirect(to: Routes.book_path(conn, :index))

    {:error, %Ecto.Changeset{} = changeset} ->
      IO.inspect("ERRORACOOOOOO????")
      authorList = [{:"", ""} | DAuthor.list_AllIdNameAuthors()]
      categoryList = [{:"", ""} | DAuthor.list_AllIdNameCategories()]
      render(conn, "new.html", changeset: changeset, authors: authorList, categories: categoryList)











FUNCION INICIAL PARA CREAR LIBROS

  def create(conn, %{"book" => book_params}) do
    case DBooks.create_book(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Libro dado de alta correctamente.")
        |> redirect(to: Routes.book_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, authors: authorList, categories: categoryList)
    end
  end
"""



  @doc """
  def createRelAuthorBook(conn, book, authors) do
    case RelationsBooks.create_rel_book_author(book.id, book.inserted_at, authors) do
      {:ok, count} ->
        IO.inspect("a")
        IO.inspect(count)
        conn
        |> put_flash(:info, "Relacion Autores-alta correctamente.")
        |> redirect(to: Routes.book_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect("FALLASTE RELAUTOR")
        authors = DAuthor.list_AllIdNameAuthors()
        categories =  DCategory.list_AllIdNameCategories()
        render(conn, "new.html", changeset: changeset, authors: authors, categories: categories)
    end
  end

  def createRelCategoryBook(conn, book, categories) do
    case RelationsBooks.create_rel_book_category(book.id, book.inserted_at, categories) do
      {:ok, _count} ->
        conn
        |> put_flash(:info, "Relacion Categorias-alta correctamente.")

      {:error, %Ecto.Changeset{} = changeset} ->
        authors = DAuthor.list_AllIdNameAuthors()
        categories =  DCategory.list_AllIdNameCategories()
        render(conn, "new.html", changeset: changeset, authors: authors, categories: categories)
    end
  end
"""
  def show(conn, %{"id" => id}) do
    book = DBooks.get_book!(id)
    render(conn, "show.html", book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = DBooks.get_book!(id)
    authors = DAuthor.list_AllIdNameAuthors()
    categories =  DCategory.list_AllIdNameCategories()
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

    @doc """
  def getIdForAuthorSelected(authors) do
    for category <- categories do category.name end
  end

  def getIdForCategorySelected(categories) do
    for category <- categories do category.name end
  end
"""

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
