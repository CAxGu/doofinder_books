defmodule DoofinderBooksWeb.BookControllerTest do
  use DoofinderBooksWeb.ConnCase

  import DoofinderBooks.DBooksFixtures

  @create_attrs %{authors: "some authors", categories: "some categories", description: "some description", isbn: "some isbn", language: "some language", publishing: "some publishing", publishing_date: ~D[2021-11-26], retired_date: ~D[2021-11-26], title: "some title"}
  @update_attrs %{authors: "some authors", categories: "some categories", description: "some updated description", isbn: "some updated isbn", language: "some updated language", publishing: "some updated publishing", publishing_date: ~D[2021-11-27], retired_date: ~D[2021-11-27], title: "some updated title"}
  @invalid_attrs %{authors: nil, categories: nil, description: nil, isbn: nil, language: nil, publishing: nil, publishing_date: nil, retired_date: nil, title: nil}

  describe "index" do
    test "lists all books", %{conn: conn} do
      conn = get(conn, Routes.book_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Books"
    end
  end

  describe "new book" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.book_path(conn, :new))
      assert html_response(conn, 200) =~ "New Book"
    end
  end

  describe "create book" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.book_path(conn, :create), book: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.book_path(conn, :show, id)

      conn = get(conn, Routes.book_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Book"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.book_path(conn, :create), book: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Book"
    end
  end

  describe "edit book" do
    setup [:create_book]

    test "renders form for editing chosen book", %{conn: conn, book: book} do
      conn = get(conn, Routes.book_path(conn, :edit, book))
      assert html_response(conn, 200) =~ "Edit Book"
    end
  end

  describe "update book" do
    setup [:create_book]

    test "redirects when data is valid", %{conn: conn, book: book} do
      conn = put(conn, Routes.book_path(conn, :update, book), book: @update_attrs)
      assert redirected_to(conn) == Routes.book_path(conn, :show, book)

      conn = get(conn, Routes.book_path(conn, :show, book))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put(conn, Routes.book_path(conn, :update, book), book: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Book"
    end
  end

  describe "delete book" do
    setup [:create_book]

    test "deletes chosen book", %{conn: conn, book: book} do
      conn = delete(conn, Routes.book_path(conn, :delete, book))
      assert redirected_to(conn) == Routes.book_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.book_path(conn, :show, book))
      end
    end
  end

  defp create_book(_) do
    book = book_fixture()
    %{book: book}
  end
end