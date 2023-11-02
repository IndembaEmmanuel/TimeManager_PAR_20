defmodule TimeManagerWeb.AuthController do
  use TimeManagerWeb, :controller
  import Hasher
  import Ecto.Query


def auth(conn, %{"email" => email, "password" => password}) do
  #json conn , %{"email" => email, "password" => password}
  req = from(u in TimeManager.User, where: u.email == ^email)


  user = TimeManager.Repo.one(req)


  # @signing_salt "user auth"
  # token for 2 week
  # @token_age_secs 14 * 86_400

  if user do
    # json conn, Hasher.salted_password_hash(password)
    if Hasher.check_password_hash(
         password,
         user.password
       ) do

      data = %{email: user.email, role: user.role}

      user_token = Phoenix.Token.sign(TimeManagerWeb.Endpoint, "user auth", data, max_age: 86400)

      updated_params = %{token: user_token}

      updated_record = TimeManager.User.changeset(user, updated_params)

      case TimeManager.Repo.update(updated_record) do
        {:ok, _} ->
          conn
          |> put_status(:ok)
          |> json(%{message: "User Token generated successfully", token: user_token, user_id: user.id})

        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{errors: Ecto.Changeset.traverse_errors(changeset)})
      end
    else
      # Handle the case where the password doesn't match
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Unauthorized"})

      conn
      |> put_status(:not_found)
      |> json(%{error: "Email or password is not correct"})
    end
  else
    conn
    |> put_status(:not_found)
    |> json(%{error: "Email or password is not correct"})
  end
end

def verfication(conn, %{"email" => email, "token" => user_token}) do
  req = from(u in TimeManager.User, where: u.email == ^email)
  user = TimeManager.Repo.one(req)

  if user do
    # json conn, Hasher.salted_password_hash(password)
    case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", user_token) do
      {:ok, email} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "User Token is valid", valid: true})

      {:error, changeset} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Unauthorized"})
    end
  else
    conn
    |> put_status(:not_found)
    |> json(%{error: "Something went wrong"})
  end
end

def logout(conn, %{"email" => email}) do
  req = from(u in TimeManager.User, where: u.email == ^email)
  user = TimeManager.Repo.one(req)

  if user do
    # json conn, Hasher.salted_password_hash(password)
    updated_params = %{token: "null"}

    updated_record = TimeManager.User.changeset(user, updated_params)

    case TimeManager.Repo.update(updated_record) do
      {:ok, _} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "User signed out successfully"})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: Ecto.Changeset.traverse_errors(changeset)})
    end

    # Handle the case where the password doesn't match
  else
    conn
    |> put_status(:not_found)
    |> json(%{error: "Something went wrong"})
  end
end

end
