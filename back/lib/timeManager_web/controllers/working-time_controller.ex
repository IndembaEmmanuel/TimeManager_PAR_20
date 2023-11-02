defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller
  import Ecto.Query

  # GET (ALL) method : http://localhost:4000/api/workingtimes/:userID?start=XXX&end=YYY
  def index(conn, %{"user_id" => user_id, "start" => start}) do
    user = TimeManager.Repo.get(TimeManager.User, user_id)
    if user do
      req = from(t in TimeManager.WorkingTime, where: t.user_id == ^user_id or t.start == ^start)
      working_times = TimeManager.Repo.one(req)

      case working_times do
        nil ->
          conn
          |> put_status(:not_found)
          |> json(%{error: "This start time for this user not fount"})

        _ ->
          json conn, working_times
      end
    else
      conn
      |> put_status(:not_found)
      |> json(%{error: "User ID is not defined"})
    end
  end


  # GET (ONE) method : http://localhost:4000/api/workingtimes/:userID/:id
  def index(conn, %{"user_id" => user_id, "id" => working_times_id}) do
    user = TimeManager.Repo.get(TimeManager.User, user_id)

    if user do
      req = from(t in TimeManager.WorkingTime, where: t.user_id == ^user_id and t.id == ^working_times_id)
      working_times = TimeManager.Repo.one(req)

    case working_times do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Working times not found"})

      _ ->
        json conn, working_times
    end
  end
end

  # POST method : http://localhost:4000/api/workingtimes/:userID
  def create(conn, %{"user_id" => user_id, "params" => params}) do
    user = TimeManager.Repo.get(TimeManager.User, user_id)

    if user do
      start_working_time = Map.get(params, "start_working_time")
      end_working_time = Map.get(params, "end_working_time")

      params_to_create = %{
        user_id: user_id,
        start: start_working_time,
        end: end_working_time
      }
      changeset = TimeManager.WorkingTime.changeset(%TimeManager.WorkingTime{}, params_to_create)
      working_times = TimeManager.Repo.insert(changeset)
      if working_times do
          conn
          |> put_status(:ok)
          |> json(%{message: "Working time created successfully"})
      else
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{message: "Working time wasn't created"})
      end
    else
      conn
      |> put_status(:not_found)
      |> json(%{error: "User ID is not defined"})
    end
  end

  # PUT method : http://localhost:4000/api/workingtimes/:id
  def update(conn, %{"working_time_id" => working_time_id, "params" => params}) do
    working_time = TimeManager.Repo.get(TimeManager.WorkingTime, working_time_id)

    if working_time do
      start_working_time = Map.get(params, "start_working_time")
      end_working_time = Map.get(params, "end_working_time")

      params_to_create = %{
        start: start_working_time,
        end: end_working_time
      }
      changeset = TimeManager.WorkingTime.changeset(%TimeManager.WorkingTime{}, params_to_create)
      working_times = TimeManager.Repo.insert(changeset)
      if working_times do
          conn
          |> put_status(:ok)
          |> json(%{message: "Working time updated successfully"})
      else
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{message: "Working time wasn't updated"})
      end
    else
      conn
      |> put_status(:not_found)
      |> json(%{error: "Working time ID is not defined"})
    end
  end

  # DELETE method : http://localhost:4000/api/workingtimes/:id
  def delete(conn, %{"working_time_id" => working_time_id}) do
    working_time = TimeManager.Repo.get(TimeManager.WorkingTime, working_time_id)

    if working_time do
      case TimeManager.Repo.delete(working_time) do
        {:ok, _} ->
          conn
          |> put_status(:ok)
          |> json(%{message: "Working time deleted successfully"})

        _ ->
          conn
          |> put_status(:internal_server_error)
          |> json(%{error: "Failed to delete the Working time"})
      end
    else
      conn
      |> put_status(:not_found)
      |> json(%{error: "Working time ID is not defined"})
    end
  end
end
