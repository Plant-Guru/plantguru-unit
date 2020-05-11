defmodule PlantGuruUnit.Supervisor do
    use Supervisor

    @name PlantGuruUnit.Supervisor

    def start_link(port) do
        Supervisor.start_link(__MODULE__, port, name: @name)
    end

    def init(port) do
        children = [
            supervisor(PlantGuruUnit.ServerSupervisor, [port]),
            worker(PlantGuruUnit.Storage, [[], []])
        ]

        supervise(children, strategy: :one_for_one)
    end
end