defmodule PlantGuruConfigurator.MixProject do
  use Mix.Project

  def project do
    [
      app: :plantguru_configurator,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.2"},
      {:cowboy, "< 2.8.0", override: true},
      {:jason, "~> 1.2"}
    ]
  end
end
