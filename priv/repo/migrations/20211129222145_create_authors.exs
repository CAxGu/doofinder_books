defmodule DoofinderBooks.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :fullname, :string
      add :pseudonym, :string
      add :birth, :date
      add :death, :date
      add :nationality, :string

      timestamps()
    end
  end
end
