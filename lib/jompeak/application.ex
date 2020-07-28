defmodule Jompeak.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Jompeak.Repo,
      # Start the Telemetry supervisor
      JompeakWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Jompeak.PubSub},
      # Start the Endpoint (http/https)
      JompeakWeb.Endpoint
      # Start a worker by calling: Jompeak.Worker.start_link(arg)
      # {Jompeak.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Jompeak.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    JompeakWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
