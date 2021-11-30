defmodule DoofinderBooks.DAuthorTest do
  use DoofinderBooks.DataCase

  alias DoofinderBooks.DAuthor

  describe "authors" do
    alias DoofinderBooks.DAuthor.Author

    import DoofinderBooks.DAuthorFixtures

    @invalid_attrs %{birth: nil, death: nil, fullname: nil, nationality: nil, pseudonym: nil}

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert DAuthor.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert DAuthor.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      valid_attrs = %{birth: ~D[2021-11-28], death: ~D[2021-11-28], fullname: "some fullname", nationality: "some nationality", pseudonym: "some pseudonym"}

      assert {:ok, %Author{} = author} = DAuthor.create_author(valid_attrs)
      assert author.birth == ~D[2021-11-28]
      assert author.death == ~D[2021-11-28]
      assert author.fullname == "some fullname"
      assert author.nationality == "some nationality"
      assert author.pseudonym == "some pseudonym"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DAuthor.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      update_attrs = %{birth: ~D[2021-11-29], death: ~D[2021-11-29], fullname: "some updated fullname", nationality: "some updated nationality", pseudonym: "some updated pseudonym"}

      assert {:ok, %Author{} = author} = DAuthor.update_author(author, update_attrs)
      assert author.birth == ~D[2021-11-29]
      assert author.death == ~D[2021-11-29]
      assert author.fullname == "some updated fullname"
      assert author.nationality == "some updated nationality"
      assert author.pseudonym == "some updated pseudonym"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = DAuthor.update_author(author, @invalid_attrs)
      assert author == DAuthor.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = DAuthor.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> DAuthor.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = DAuthor.change_author(author)
    end
  end
end
