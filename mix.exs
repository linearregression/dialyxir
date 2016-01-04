defmodule Dialyxir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :dialyxir,
      version: "0.3.1",
      elixir: "~> 1.0",
      description: description,
      source_url: project_url,
      homepage_url: project_url,
      package: package,
      deps: [],
      dialyzer: [
         plt_add_apps: [:asn1,
           :crypto,
           :edoc,
           :erts,
           :eunit,
           :inets,
           :kernel,
           :mnesia,
           :public_key,
           :ssl,
           :stdlib,
           :xmerl
          ],
       plt_file: "plts/#{plt_filename}",
       flags: ["--no_native"]
     ],
    ]
  end

  defp description do
    """
    Mix tasks to simplify use of Dialyzer in Elixir projects.
    """
  end

  defp project_url do
    """
    "https://github.com/jeremyjh/dialyxir"
    """
  end

  def plt_filename do
    "otp-#{otp_release}-elixir-#{elixir_release}.plt"
  end

  def application do
    [applications: [:logger]]
  end

  defp package do
    [files: ["lib", "mix.exs", "README.md", "LICENSE"],
     maintainers: ["Jeremy Huffman"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => project_url}]
  end

  defp otp_release do
    case System.get_env("TRAVIS_OTP_RELEASE") do
      nil     -> :erlang.system_info(:otp_release)
      release -> release
    end
  end

  defp elixir_release do
    case System.get_env("TRAVIS_ELIXIR_VERSION") do
      nil     -> System.version
      release -> release
    end
  end
end
