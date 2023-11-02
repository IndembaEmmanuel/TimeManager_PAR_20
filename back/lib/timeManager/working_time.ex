defmodule TimeManager.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :start, :end, :user_id]}

  schema "workingtimes" do
    field :start, :utc_datetime
    field :end, :utc_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:user_id, :start, :end])
    |> validate_required([:start, :end])
  end
end
