defmodule Mix.Tasks.Assets.Audit do
  use Mix.Task

  @shortdoc "Audit web assets for security vulnerabilties"
  @assets Path.expand("../../../assets", __DIR__)

  def run(_) do
    System.cmd(
      "yarn",
      ["audit"],
      cd: @assets,
      stderr_to_stdout: true,
      into: IO.stream(:stdio, :line)
    )
  end
end
