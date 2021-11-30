defmodule DoofinderBooks.Repo.Migrations.CreateRelBooksCategories do
  use Ecto.Migration

  def change do
    create table(:rel_books_categories) do
      add :book_id, :integer
      add :category_id, :integer

      timestamps()
    end
  end
end
