defmodule PlantGuruMqtt do
  use Supervisor
  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    children = [
      {Tortoise.Connection,
       [
         client_id: Application.get_env(:plantguru_mqtt, PlantGuruMqtt)[:client_id],
         server: {
          Tortoise.Transport.Tcp,
            host: Application.get_env(:plantguru_mqtt, PlantGuruMqtt)[:host],
            port: Application.get_env(:plantguru_mqtt, PlantGuruMqtt)[:port]
          },
          handler: {PlantGuruEventHandler, []}
       ]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
