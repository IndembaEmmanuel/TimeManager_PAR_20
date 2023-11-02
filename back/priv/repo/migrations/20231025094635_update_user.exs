defmodule TimeManager.Repo.Migrations.UpdateUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :age, :integer
      add :role, :string, default: "employee", null: false
      add :password, :string
      add :token, :string
      add :gender, :string, null: true
      add :team_id, references(:teams)
    end
  end

end
