defmodule DoofinderBooks.Repo.Migrations.CreateRelBooksAuthors do
  use Ecto.Migration

  def change do
    create table(:rel_books_authors) do
      add :book_id, :integer
      add :author_id, :integer

      timestamps()
    end
  end
end
