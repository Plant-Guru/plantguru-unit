defmodule PlantGuruMqtt do
  use Supervisor
  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    {:ok, hostname} = :inet.gethostname
    children = [
      {Tortoise.Connection,
       [
         client_id: hostname,
         server: {
          Tortoise.Transport.Tcp,
            host: Application.get_env(:plant_guru_mqtt, PlantGuruMqtt)[:host],
            port: Application.get_env(:plant_guru_mqtt, PlantGuruMqtt)[:port]
          },
          handler: {PlantGuruEventHandler, []}
       ]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
