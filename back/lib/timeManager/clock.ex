defmodule TimeManager.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :status, :time]}

  schema "clocks" do
    field :status, :boolean, default: true
    field :time, :utc_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status])
    |> validate_required([:time, :status])
  end
end
