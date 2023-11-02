defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller
  import Ecto.Query


  # get user based on his email or username
  def index(conn, %{"email" => email, "username" => username}) do
    req = from(u in TimeManager.User, where: u.email == ^email or u.username == ^username)
    user = TimeManager.Repo.one(req)

    case user do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      _ ->
        json(conn, user)
    end
  end

  # get user based on his id
  def show(conn, %{"id" => user_id}) do
    task = TimeManager.Repo.get(TimeManager.User, user_id)

    case task do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      _ ->
        json(conn, task)
    end
  end

  # create new user with all attibutes
  def create(conn, %{
        "username" => username,
        "firstname" => firstname,
        "lastname" => lastname,
        "age" => age,
        "gender" => gender,
    }) do
    changeset =
      TimeManager.User.changeset(%TimeManager.User{}, %{
        "username" => username,
        "email" => firstname <> "." <> lastname <> "@epitech.eu",
        "firstname" => firstname,
        "lastname" => lastname,
        "age" => age,
        "password" => username <> "@Epitech",
        "gender" => gender,
      })

    case changeset.valid? do
      true ->
        # The password meets the requirements, proceed with user creation
        updated_changeset = Ecto.Changeset.change(changeset, password: Hasher.salted_password_hash(username <> "@Epitech"))


        case TimeManager.Repo.insert(updated_changeset) do
          {:ok, _} ->
            conn
            |> put_status(:created)
            |> json(%{message: "User created successfully"})

          {:error, _} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{message: "User wasn't created"})
        end
        # Redirect to a success page or do something else

      false ->
        conn
        # The password does not meet the requirements, render the registration form with errors
        |> put_status(:unprocessable_entity)
        |> json(%{error: "error"})
    end

  end

  # delete user with his id
  def delete(conn, %{"id" => user_id}) do
    user = TimeManager.Repo.get(TimeManager.User, user_id)

    case user do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      _ ->
        case TimeManager.Repo.delete(user) do
          {:ok, _} ->
            conn
            |> json(%{message: "User deleted successfully"})

          _ ->
            conn
            |> put_status(:internal_server_error)
            |> json(%{error: "Failed to delete the User"})
        end
    end
  end

  # update user and must pass all attributes
  def update(conn, %{"id" => id, "params" => params}) do
    user = TimeManager.Repo.get(TimeManager.User, id)

    case user do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      _ ->
        username = Map.get(params, "username")
        email = Map.get(params, "email")
        firstname = Map.get(params, "firstname")
        lastname = Map.get(params, "lastname")
        age = Map.get(params, "age")
        password = Map.get(params, "password")
        role = Map.get(params,"role")
        team_id = Map.get(params, "team_id")
        gender = Map.get(params, "gender")

        updated_params = %{
          username: username,
          email: email,
          firstname: firstname,
          lastname: lastname,
          age: age,
          password: password,
          role: role,
          gender: gender,
          team_id: team_id
        }

        updated_record = TimeManager.User.changeset(user, updated_params)

        case TimeManager.Repo.update(updated_record) do
          {:ok, _updated_user} ->
            conn
            |> put_status(:ok)
            |> json(%{message: "User updated successfully"})

          {:error} ->
            conn
            |> put_status(:unprocessable_entity)

            # |> json(%{errors: Ecto.Changeset.traverse_errors(changeset)})
        end
    end
  end


  # TODO: - Other controller actions (show, create, update, delete) can remain as generated.
end
