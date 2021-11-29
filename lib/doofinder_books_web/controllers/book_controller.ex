defmodule DoofinderBooksWeb.BookController do
  use Timex
  use DoofinderBooksWeb, :controller

  alias DoofinderBooks.DBooks
  alias DoofinderBooks.DBooks.Book

  def index(conn, _params) do
    books = DBooks.list_books()
    render(conn, "index.html", books: books)
  end

  def new(conn, _params) do
    changeset = DBooks.change_book(%Book{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do

    #Obtenemos la fecha desde el formulario y la transformamos al formato esperado por el modelo
    book_params_updated = formatToInternalDate(book_params)

    case DBooks.create_book(book_params_updated) do
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
    changeset = DBooks.change_book(book)
    render(conn, "edit.html", book: book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = DBooks.get_book!(id)

    #Obtenemos la fecha desde el formulario y la transformamos al formato esperado por el modelo
    book_params_updated = formatToInternalDate(book_params)

    case DBooks.update_book(book, book_params_updated) do
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


  def formatToInternalDate(book_params) do
    #IO.inspect(book_params)
    paramPublishingDate = book_params["publishing_date"]
    #TODO implementar un control de si llega esta fecha
    #paramRetiredDate = ""

    splitBy = "/"
    dateSplited = String.split(paramPublishingDate,splitBy)
    day = Enum.at(dateSplited, 0)
    month = Enum.at(dateSplited, 1)
    year = Enum.at(dateSplited, 2)
    resultPublishingDate = year<>"-"<>month<>"-"<>day
    book_params = %{book_params | "publishing_date" => resultPublishingDate}
    Map.replace(book_params, :publishing_date, resultPublishingDate)
  end

  def formatToExternalDate(book_params) do
    #IO.inspect(book_params)
    paramPublishingDate = book_params["publishing_date"]
    #TODO implementar un control de si llega esta fecha
    #paramRetiredDate = ""

    splitBy = "-"
    dateSplited = String.split(paramPublishingDate,splitBy)
    day = Enum.at(dateSplited, 2)
    month = Enum.at(dateSplited, 1)
    year = Enum.at(dateSplited, 0)
    resultPublishingDate = day<>"/"<>month<>"/"<>year
    book_params = %{book_params | "publishing_date" => resultPublishingDate}
    Map.replace(book_params, :publishing_date, resultPublishingDate)
  end
end
