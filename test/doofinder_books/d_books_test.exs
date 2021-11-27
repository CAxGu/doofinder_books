defmodule DoofinderBooks.DBooksTest do
  use DoofinderBooks.DataCase

  alias DoofinderBooks.DBooks

  describe "books" do
    alias DoofinderBooks.DBooks.Book

    import DoofinderBooks.DBooksFixtures

    @invalid_attrs %{authors: nil, categories: nil, description: nil, isbn: nil, language: nil, publishing: nil, publishing_date: nil, retired_date: nil, title: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert DBooks.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert DBooks.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{authors: "some authors", categories: "some categories", description: "some description", isbn: "some isbn", language: "some language", publishing: "some publishing", publishing_date: ~D[2021-11-26], retired_date: ~D[2021-11-26], title: "some title"}

      assert {:ok, %Book{} = book} = DBooks.create_book(valid_attrs)
      assert book.authors == "some authors"
      assert book.categories == "some categories"
      assert book.description == "some description"
      assert book.isbn == "some isbn"
      assert book.language == "some language"
      assert book.publishing == "some publishing"
      assert book.publishing_date == ~D[2021-11-26]
      assert book.retired_date == ~D[2021-11-26]
      assert book.title == "some title"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DBooks.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{authors: "some update authors", categories: "some update categories", description: "some updated description", isbn: "some updated isbn", language: "some updated language", publishing: "some updated publishing", publishing_date: ~D[2021-11-27], retired_date: ~D[2021-11-27], title: "some updated title"}

      assert {:ok, %Book{} = book} = DBooks.update_book(book, update_attrs)
      assert book.authors == "some update authors"
      assert book.categories == "some update categories"
      assert book.description == "some updated description"
      assert book.isbn == "some updated isbn"
      assert book.language == "some updated language"
      assert book.publishing == "some updated publishing"
      assert book.publishing_date == ~D[2021-11-27]
      assert book.retired_date == ~D[2021-11-27]
      assert book.title == "some updated title"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = DBooks.update_book(book, @invalid_attrs)
      assert book == DBooks.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = DBooks.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> DBooks.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = DBooks.change_book(book)
    end
  end
end
