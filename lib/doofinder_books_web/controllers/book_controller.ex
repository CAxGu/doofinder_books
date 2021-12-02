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

  @doc """
  Se obtienen todos los libros con su información asociada.
  Mapea lo devuelto por la a un objeto de tipo Book, para poder tratarlo desde el form.
  """
  def index(conn, _params) do
    books = DBooks.list_all_books_info()
    map = fromDB_to_map(books)
    render(conn, "index.html",books: map)
  end

  def new(conn, _params) do
    # Mapeamos autores y categorías para convertirlos en un select multiple
    # Añadimos un campo vacío a los array para obligar al usuario a seleccionar 1 autor y 1 categoría
    authorList = [{:"", ""} | DAuthor.list_AllIdNameAuthors()]
    categoryList = [{:"", ""} | DCategory.list_AllIdNameCategories()]
    changeset = Book.form_createBook_changeset(%Book{authorsInfo: [%Rel_book_author{}], categoriesInfo: [%Rel_book_category{}]})

    #changeset = DBooks.change_book(%Book{})
    render(conn, "new.html", authors: authorList, categories: categoryList, changeset: changeset)
  end

  @doc """
  Función que da de alta un libro nuevo, relacionando en las tablas correspondintes sus respectivos autor y categoría
  """
  def create(conn, %{"book" => book_params}) do
    authorList = [{:"", ""} | DAuthor.list_AllIdNameAuthors()]
    categoryList = [{:"", ""} | DCategory.list_AllIdNameCategories()]
    case DBooks.create_book_with_relations(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Libro dado de alta correctamente.")
        |> redirect(to: Routes.book_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", authors: authorList, categories: categoryList, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = DBooks.get_all_book_info!(id)
    render(conn, "show.html", book: book)
  end

  def edit(conn, %{"id" => id}) do
    books = DBooks.get_all_book_info!(id)
    map = fromDB_to_map(books)
    book = Enum.at(map, 0)
    book_ = DBooks.get_book!(id)

    upbook = fromDB_to_editmap(book,book_)
    authorList = [{:"", ""} | DAuthor.list_AllIdNameAuthors()]
    categoryList = [{:"", ""} | DCategory.list_AllIdNameCategories()]
    changeset = DBooks.change_book(upbook)

    render(conn, "edit.html", book: upbook, authors: authorList, categories: categoryList, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book_ = DBooks.get_book!(id)

    #prueba = fromDB_to_editmap(book,book_)

    #IO.inspect(prueba)

    books = DBooks.get_all_book_info!(id)
    map = fromDB_to_map(books)
    book = Enum.at(map, 0)
    #id_author = book_params["author_id"]
    #id_category = book_params["category_id"]
    #id_book = book_.id



    rel_author = RelationsBooks.get_by_rel_book_author!(id)
    rel_category = RelationsBooks.get_by_rel_book_category!(id)


    #pureba2 = RelationsBooks.get_by_rel_book_category!(id)

    case DBooks.update_book_and_relations(book_, book_params, rel_author, rel_category) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Libro actualizado correctamente.")
        |> redirect(to: Routes.book_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        authorList = [{:"", ""} | DAuthor.list_AllIdNameAuthors()]
        categoryList = [{:"", ""} | DCategory.list_AllIdNameCategories()]
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  @doc """
  Borrado de libros y su relación de autor, categorias asociadas
  """
  def delete(conn, %{"id" => id}) do

    book = DBooks.get_book!(id)
    {:ok, _book} = DBooks.delete_book_and_relations(book)

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

  def fromDB_to_map(books) do
    Enum.map(books, fn(book) ->
      map_book = Map.merge(%Book{}, book)
    end)
  end

  def fromDB_to_editmap(book,book_) do
      Map.merge(book, book_)
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
