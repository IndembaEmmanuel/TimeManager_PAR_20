defmodule TimeManagerWeb.ActionController do
  use TimeManagerWeb, :controller
  import Ecto.Query


  # must pass the user id as id , new role and token
  def userRoleModification(conn, %{"id" => id, "role" => role, "token" => user_token}) do
    case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", user_token) do
      {:ok, data} ->
        if data.role != "employee" do
          if data.role == "manager"  do
            req = from(u in TimeManager.User, where: u.role == "employee" and u.id == ^id)
            user = TimeManager.Repo.one(req)
            if user do

              # json conn, Hasher.salted_password_hash(password)
              updated_params = %{
                role: role
              }
              updated_record = TimeManager.User.changeset(user, updated_params)

              case TimeManager.Repo.update(updated_record) do
                {:ok, _updated_user} ->
                  conn
                  |> put_status(:ok)
                  |> json(%{message: "Role of User updated successfully"})

                {:error, _} ->
                  conn
                  |> put_status(:unprocessable_entity)
                  |> json(%{message: "Try Again"})
                  #|> json(%{errors: Ecto.Changeset.traverse_errors(changeset)})
              end

            else
              conn
              |> put_status(:not_found)
              |> json(%{error: "User not found"})
            end
          else if data.role == "super_manager" do
            req = from(u in TimeManager.User, where: (u.role == "employee" or u.role == "manager") and u.id == ^id)
            user = TimeManager.Repo.one(req)
            if user do

              # json conn, Hasher.salted_password_hash(password)
              updated_params = %{
                role: role
              }
              updated_record = TimeManager.User.changeset(user, updated_params)

              case TimeManager.Repo.update(updated_record) do
                {:ok, _updated_user} ->
                  conn
                  |> put_status(:ok)
                  |> json(%{message: "Role of User updated successfully"})

                {:error, _} ->
                  conn
                  |> put_status(:unprocessable_entity)
                  |> json(%{message: "Try Again"})
                  #|> json(%{errors: Ecto.Changeset.traverse_errors(changeset)})
              end

            else
              conn
              |> put_status(:not_found)
              |> json(%{error: "it is forbidden to modify a super manager"})
            end
          end
        end
        else

        json(conn, "unauthorized for this action")

        end




      {:error} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Unauthorized"})
    end
  end

  # affect employee into team or make manager as the head of a team - pass the user id as id, team_id and token
  def userAssignment(conn, %{"id" => id, "team_id" => team_id, "token" => user_token}) do
    case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", user_token) do
      {:ok, data} ->
        if data.role != "employee" do
          if data.role == "manager"  do
            req = from(u in TimeManager.User, where: u.role == "employee" and u.id == ^id)
            user = TimeManager.Repo.one(req)
            if user do

              # json conn, Hasher.salted_password_hash(password)
              updated_params = %{
                team_id: team_id
              }
              updated_record = TimeManager.User.changeset(user, updated_params)

              case TimeManager.Repo.update(updated_record) do
                {:ok, _updated_user} ->
                  conn
                  |> put_status(:ok)
                  |> json(%{message: "User has joined the team successfully"})

                {:error, _} ->
                  conn
                  |> put_status(:unprocessable_entity)
                  |> json(%{message: "Try Again"})
                  #|> json(%{errors: Ecto.Changeset.traverse_errors(changeset)})
              end

            else
              conn
              |> put_status(:not_found)
              |> json(%{error: "User not found"})
            end
          else if data.role == "super_manager" do
            req = from(u in TimeManager.User, where: u.role == "manager" and u.id == ^id)
            user = TimeManager.Repo.one(req)
            team = TimeManager.Repo.get(TimeManager.Team,team_id)
            if user do

              # json conn, Hasher.salted_password_hash(password)
              updated_params = %{
                manager_id: user.id
              }
              updated_record = TimeManager.Team.changeset(team, updated_params)

              case TimeManager.Repo.update(updated_record) do
                {:ok, _updated_user} ->
                  conn
                  |> put_status(:ok)
                  |> json(%{message: "the team has manager successfully"})

                {:error, _} ->
                  conn
                  |> put_status(:unprocessable_entity)
                  |> json(%{message: "Try Again"})
                  #|> json(%{errors: Ecto.Changeset.traverse_errors(changeset)})
              end

            else
              conn
              |> put_status(:not_found)
              |> json(%{error: "it is forbidden to modify a super manager"})
            end
          end
        end
        else

        json(conn, "unauthorized for this action")

        end




      {:error} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Unauthorized"})
    end
  end

end
