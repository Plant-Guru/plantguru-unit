defmodule PlantGuruConfigurator do
  use Supervisor
  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    children = [
      # Use Plug.Cowboy.child_spec/3 to register our endpoint as a plug
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: PlantGuruConfigurator.Endpoint,
        options: [port: 80]
      )
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
