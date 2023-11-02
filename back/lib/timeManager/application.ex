defmodule TimeManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  # List of extra applications to start
  def extra_applications do
    [:logger, :cors_plug, :TimeManager]
  end

  @impl true
  def start(_type, _args) do
    children = [
      TimeManagerWeb.Telemetry,
      TimeManager.Repo,
      {DNSCluster, query: Application.get_env(:timeManager, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TimeManager.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TimeManager.Finch},
      # Start a worker by calling: TimeManager.Worker.start_link(arg)
      # {TimeManager.Worker, arg},
      # Start to serve requests, typically the last entry
      TimeManagerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TimeManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TimeManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end


end
