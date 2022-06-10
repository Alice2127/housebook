defmodule Housebook.Repo.Migrations.CreateOutgos do
  use Ecto.Migration

  def change do
    create table(:outgos) do
      add :group_id, :integer
      add :payment, :integer

      timestamps()
    end
  end
end
