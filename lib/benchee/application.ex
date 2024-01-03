defmodule Benchee.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BencheeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Benchee.PubSub},
      # Start Finch
      {Finch, name: Benchee.Finch},
      # Start the Endpoint (http/https)
      BencheeWeb.Endpoint
      # Start a worker by calling: Benchee.Worker.start_link(arg)
      # {Benchee.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Benchee.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BencheeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
