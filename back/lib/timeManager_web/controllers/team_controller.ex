defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller

  def index(conn, _params) do
    # users = TimeManager.Repo.all(TimeManager.User)
    teams = TimeManager.Repo.all(TimeManager.Team)

    case teams do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "None"})

      _ ->
        json(conn, teams)
    end
  end

  def show(conn, %{"id" => id,"user_token" => user_token} ) do

    case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", user_token) do
      {:ok, data} ->

        if data.role == "manager" or data.role == "super_manager" do
          team = TimeManager.Repo.get(TimeManager.Team, id)
          case team do
            nil ->
              conn
              |> put_status(:not_found)
              |> json(%{error: "Team not found"})

            _ ->
              json(conn, team)
          end

        else
          json(conn, "unauthorized for this action")
        end
      {:error, _} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "prb"})
    end

  end

  def create(conn, %{"name" => name, "manager_id" => manager_id,"token" => user_token}) do
    changeset =
      TimeManager.Team.changeset(%TimeManager.Team{}, %{
        "name" => name,
        "manager_id" => manager_id,
      })


      case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", user_token) do
        {:ok, data} ->

          if data.role == "manager" or data.role == "super_manager" do

            case TimeManager.Repo.insert(changeset) do
              {:ok, _} ->
                conn
                |> put_status(:created)
                |> json(%{message: "Team created successfully"})

              {:error, _} ->
                conn
                |> put_status(:unprocessable_entity)
                |> json(%{message: "Team wasn't created"})
            end

          else
            json(conn, "unauthorized for this action")
          end
        {:error, _} ->
          conn
          |> put_status(:not_found)
          |> json(%{error: "prb"})
      end



  end

  def delete(conn, %{"id" => id,"token" => user_token}) do

    team = TimeManager.Repo.get(TimeManager.Team, id)


      case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", user_token) do
        {:ok, data} ->

          if data.role == "manager" or data.role == "super_manager" do

            case TimeManager.Repo.delete(team) do
              {:ok, _} ->
                conn
                |> put_status(:created)
                |> json(%{message: "Team deleted successfully"})

              {:error, _} ->
                conn
                |> put_status(:unprocessable_entity)
                |> json(%{message: "Team wasn't created"})
            end

          else
            json(conn, "unauthorized for this action")
          end
        {:error, _} ->
          conn
          |> put_status(:not_found)
          |> json(%{error: "Session is invalid"})
      end



  end




  # TODO: - Other controller actions (show, create, update, delete) can remain as generated.
end
