defmodule PlantGuruUnit.MixFile do
    use Mix.Project

    @default_port 5683

    def project do
        [
            app: :plant_guru_unit,
            version: "0.0.1",
            elixir: "~> 1.7",
            elixirc_paths: elixirc_paths(Mix.env()),
            build_embedded: Mix.env() == :prod,
            start_permanent: Mix.env() == :prod,
            aliases: aliases(),
            deps: deps()
        ]
    end


    # Configuration for the OTP application.
    #
    # Type `mix help compile.app` for more information.
    def application do
        [
            mod: {PlantGuruUnit.Application, port()},
            env: [copa_port: port(), registry_endpoint: 'coap://127.0.0.1:5683/registry'],
            extra_applications: [:logger, :runtime_tools]
        ]
    end

    # Specifies which paths to compile per environment.
    defp elixirc_paths(:test), do: ["lib", "test/support"]
    defp elixirc_paths(_), do: ["lib"]

    # Aliases are shortcuts or tasks specific to the current project.
    # For example, to install project dependencies and perform other setup tasks, run:
    #
    #     $ mix setup
    #
    # See the documentation for `Mix` for more info on aliases.
    defp aliases do
        [
            setup: ["deps.get", "cmd npm install --prefix assets"]
        ]
    end

    defp deps do
        [
            {:gen_coap, git: "https://github.com/gotthardp/gen_coap.git"},
            {:coap, git: "https://github.com/mskv/coap.git"}
        ]
    end

    defp port do
        if port = System.get_env("UNIT_PORT") do
            case Integer.parse(port) do
                {port, ""} -> port
                _ -> @default_port
            end
        else
            @default_port
        end
    end
end