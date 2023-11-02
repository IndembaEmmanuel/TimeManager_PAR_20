defmodule TimeManagerWeb.ClockingController do
  use TimeManagerWeb, :controller
  import Ecto.Query

  # GET method : http://localhost:4000/api/clocks/:userID
  def index(conn, %{"user_id" => user_id}) do
    req = from(clock in TimeManager.Clock, where: clock.user_id == ^user_id)
    clocks = TimeManager.Repo.all(req)

    case clocks do
      [] ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      _ ->
        json conn, clocks
    end
  end

  # POST method : http://localhost:4000/api/clocks/:userID
  def create(conn, %{"user_id" => user_id, "time" => time, "status" => status}) do
    user = TimeManager.Repo.get(TimeManager.User, user_id)

    if user do
      changeset = TimeManager.Clock.changeset(%TimeManager.Clock{user_id: String.to_integer(user_id)}, %{"time" => time, "status" => status})

      case TimeManager.Repo.insert(changeset) do
        {:ok} ->
          conn
          |> put_status(:created)
          |> json(%{message: "Clocking created successfully"})

        {:error} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{error: "Clocking wasn't created"})
      end
    else
      conn
      |> put_status(:not_found)
      |> json(%{error: "User ID is not defined"})
    end
  end
end
