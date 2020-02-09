defmodule Mix.Tasks.Assets.Add do
  use Mix.Task

  @shortdoc "Add web assets"
  @assets Path.expand("../../../assets", __DIR__)

  def run(packages) do
    System.cmd(
      "yarn",
      ["add"] ++ packages,
      cd: @assets,
      stderr_to_stdout: true,
      into: IO.stream(:stdio, :line)
    )
  end
end
