defmodule Mix.Tasks.Assets.Remove do
  use Mix.Task

  @shortdoc "Remove web assets"
  @assets Path.expand("../../../assets", __DIR__)

  def run(packages) do
    System.cmd(
      "yarn",
      ["remove"] ++ packages,
      cd: @assets,
      stderr_to_stdout: true,
      into: IO.stream(:stdio, :line)
    )
  end
end
