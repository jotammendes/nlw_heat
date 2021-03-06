defmodule HeatTags.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      HeatTags.Repo,
      # Start the Telemetry supervisor
      HeatTagsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HeatTags.PubSub},
      # Start the Endpoint (http/https)
      HeatTagsWeb.Endpoint,
      HeatTags.Scheduler
      # Start a worker by calling: HeatTags.Worker.start_link(arg)
      # {HeatTags.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HeatTags.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HeatTagsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
