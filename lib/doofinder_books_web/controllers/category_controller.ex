defmodule DoofinderBooksWeb.CategoryController do
  use DoofinderBooksWeb, :controller

  alias DoofinderBooks.DCategory
  alias DoofinderBooks.DCategory.Category

  def index(conn, _params) do
    categories = DCategory.list_categories()
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    changeset = DCategory.change_category(%Category{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    case DCategory.create_category(category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Categoría Dada de Alta Correctamente.")
        |> redirect(to: Routes.category_path(conn, :show, category))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = DCategory.get_category!(id)
    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = DCategory.get_category!(id)
    changeset = DCategory.change_category(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = DCategory.get_category!(id)

    case DCategory.update_category(category, category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Categoría Actualizada CorrectamenteCategory updated successfully.")
        |> redirect(to: Routes.category_path(conn, :show, category))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = DCategory.get_category!(id)
    {:ok, _category} = DCategory.delete_category(category)

    conn
    |> put_flash(:info, "Categoría Borrada Correctamente.")
    |> redirect(to: Routes.category_path(conn, :index))
  end
end
