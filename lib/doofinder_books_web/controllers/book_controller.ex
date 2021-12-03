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
    authors = DAuthor.list_authors()
    categories = DCategory.list_categories()
    map = fromDB_to_map(books)
    render(conn, "index.html",books: map, authors: authors, categories: categories)
  end

  @doc """
  Funcion que prepara formulario en modo create, precargando changeset con toda la información del id dado
  """
  def new(conn, _params) do
    # Mapeamos autores y categorías para convertirlos en un select multiple
    # Añadimos un campo vacío a los array para obligar al usuario a seleccionar 1 autor y 1 categoría
    authorList = [{:"", ""} | DAuthor.list_AllIdNameAuthors()]
    categoryList = [{:"", ""} | DCategory.list_AllIdNameCategories()]
    changeset = DBooks.change_book_relations(%Book{authorsinfo: [%Rel_book_author{}],categoriesinfo: [%Rel_book_category{}]})
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

  @doc """
  Funcion que prepara formulario en modo edit, precargando changeset con toda la información del id dado
  """
  def edit(conn, %{"id" => id}) do
    book = Enum.at(DBooks.get_book_preloaded!(id), 0)
    authorList = [{:"", ""} | DAuthor.list_AllIdNameAuthors()]
    categoryList = [{:"", ""} | DCategory.list_AllIdNameCategories()]
    changeset = DBooks.change_book_relations(book)
    render(conn, "edit.html", book: book, authors: authorList, categories: categoryList, changeset: changeset)
  end

  @doc """
  Persistencia en base de datos de los datos asociados al libro modificado
  """
  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Enum.at(DBooks.get_book_preloaded!(id), 0)
    authorList = [{:"", ""} | DAuthor.list_AllIdNameAuthors()]
    categoryList = [{:"", ""} | DCategory.list_AllIdNameCategories()]
    case DBooks.update_book_and_relations(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Libro actualizado correctamente.")
        |> redirect(to: Routes.book_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", book: book, authors: authorList, categories: categoryList, changeset: changeset)
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

  @doc """
  Retorna un mapeo del objeto obtenido desde base de datos a un map interno
  """
  def fromDB_to_map(books) do
    Enum.map(books, fn(book) ->
      map_book = Map.merge(%Book{}, book)
    end)
  end

  @doc """
  Unifica valores entre 2 maps distintos del tipo Book
  """
  def fromDB_to_editmap(book,book_) do
      Map.merge(book, book_)
  end

  @doc """
  Carga desde base de datos toda la información sobre un libro solicitado (book, auhtors y categories)
  y precarga los campos asociados al schema books
  """
  def preload_changeset_fields (books) do
    Enum.map(books, fn(book) ->
      map_book = Map.merge(%Book{authorsinfo: [%Rel_book_author{}],categoriesinfo: [%Rel_book_category{}]}, book)
    end)
  end
end
