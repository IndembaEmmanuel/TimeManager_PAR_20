defmodule TimeManager.Team do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :manager_id]}

  schema "teams" do
    field :name, :string
    field :manager_id, :integer

    timestamps(type: :utc_datetime)
  end

  def changeset(team, attrs) do
    team
    |> cast(attrs, [:id, :name, :manager_id])
    |> validate_required([:name, :manager_id])
  end
end
