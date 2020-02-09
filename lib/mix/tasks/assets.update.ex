defmodule Mix.Tasks.Assets.Upgrade do
  use Mix.Task

  @shortdoc "Upgrade web assets"
  @assets Path.expand("../../../assets", __DIR__)

  def run(packages \\ []) do
    System.cmd(
      "yarn",
      ["upgrade"] ++ packages,
      cd: @assets,
      stderr_to_stdout: true,
      into: IO.stream(:stdio, :line)
    )
  end
end
