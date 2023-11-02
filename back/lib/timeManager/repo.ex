defmodule TimeManager.Repo do
  use Ecto.Repo,
    otp_app: :timeManager,
    adapter: Ecto.Adapters.Postgres
end
