<<<<<<< HEAD
defmodule Benchee.MixProject do
  use Mix.Project

  def project do
    [
      app: :benchee,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
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
      mod: {Benchee.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.7"},
      {:phoenix_live_dashboard, "~> 0.8.0"},
      {:esbuild, "~> 0.7", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:benchee, "~> 1.0", only: :dev}

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
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind default", "esbuild default"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
=======
defmodule Benchee.Mixfile do
  use Mix.Project

  @source_url "https://github.com/bencheeorg/benchee"
  @version "1.3.0"

  def project do
    [
      app: :benchee,
      version: @version,
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      consolidate_protocols: true,
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.travis": :test,
        "safe_coveralls.travis": :test
      ],
      dialyzer: [
        flags: [:underspecs],
        plt_file: {:no_warn, "tools/plts/benchee.plt"},
        plt_add_apps: [:table]
      ],
      name: "Benchee",
      description: """
      Versatile (micro) benchmarking that is extensible. Get statistics such as:
      average, iterations per second, standard deviation and the median.
      """
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support", "mix"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    deps = [
      {:deep_merge, "~> 1.0"},
      {:statistex, "~> 1.0"},
      {:ex_guard, "~> 1.3", only: :dev},
      {:credo, "~> 1.7.2-rc.0", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.13", only: :test},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false}
    ]

    # table relies on __STACKTRACE__ which was introduced in 1.7, we still support ~>1.6 though
    # as it's optional, this does not affect the function of Benchee
    if Version.compare(System.version(), "1.7.0") == :gt do
      [{:table, "~> 0.1.0", optional: true} | deps]
    else
      deps
    end
  end

  defp package do
    [
      maintainers: ["Tobias Pfeiffer", "Devon Estes"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "https://hexdocs.pm/benchee/changelog.html",
        "GitHub" => @source_url,
        "Blog posts" => "https://pragtob.wordpress.com/tag/benchee/"
      }
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md": [],
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Readme"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: @version,
      api_reference: false,
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
>>>>>>> d1228710390ee9d871a7b31e8e458a4b334c7790
    ]
  end
end
