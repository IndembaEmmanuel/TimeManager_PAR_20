defmodule TimeManager.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :username, :email,:firstname,:lastname,:age,:token,:role,:gender,:team_id]}

  schema "users" do
    field :username, :string
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :age, :integer
    field :role, :string
    field :password, :string
    field :token, :string
    field :gender, :string
    field :team_id, :integer

    timestamps(type: :utc_datetime)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:id, :username, :email,:firstname,:lastname,:password,:age,:token,:role,:gender,:team_id])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/\S+@\S+\.\S+/)
    |> validate_format(:password, ~r/^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\p{P}\p{S}]).{7,}$/, message: "Password must meet the requirements.")
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
