defmodule DoofinderBooks.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :isbn, :string
      add :title, :string
      add :authors, :string
      add :description, :text
      add :publishing_date, :date
      add :retired_date, :date
      add :categories, :string
      add :publishing, :string
      add :language, :string

      timestamps()
    end
  end
end
