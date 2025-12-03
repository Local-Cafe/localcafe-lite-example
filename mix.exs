defmodule LocalCafe.MixProject do
  use Mix.Project

  def project do
    [
      app: :local_cafe,
      version: "0.1.0",
      elixir: "~> 1.15",
      aliases: aliases(),
      deps: deps(),
      start_permanent: Mix.env() == :prod
    ]
  end

  def application do
    [
      extra_applications: [:logger, :inets, :ssl]
    ]
  end

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix_live_view, "~> 1.1"},
      {:nimble_publisher, "~> 1.0", runtime: false},
      {:earmark, git: "https://github.com/pragdave/earmark", runtime: false, override: true},
      {:jason, "~> 1.4"},
      {:dialyxir, "~> 1.4", runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      build: ["assets.build", "build"],
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["cmd --cd assets npm install"],
      "assets.build": ["cmd --cd assets npm run build"],
      "assets.deploy": ["cmd --cd assets npm run deploy"],
      precommit: ["compile --warning-as-errors", "deps.unlock --unused", "format", "test"]
    ]
  end
end
