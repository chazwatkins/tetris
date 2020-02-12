defmodule Tetris.Points do
  def move_to_location(points, {x, y}) do
    Enum.map(points, fn {dx, dy} -> {dx + x, dy + y} end)
  end

  def transpose(points), do: Enum.map(points, fn {x, y} -> {y, x} end)

  def mirror(points), do: Enum.map(points, fn {x, y} -> {5 - x, y} end)
  def mirror(points, false), do: points
  def mirror(points, true), do: mirror(points)

  def flip(points), do: Enum.map(points, fn {x, y} -> {x, 5 - y} end)

  def rotate_90(points) do
    points
    |> transpose()
    |> mirror()
  end

  def rotate(points, 0), do: points

  def rotate(points, degrees) do
    points
    |> rotate_90()
    |> rotate(degrees - 90)
  end

  def with_color(points, color) do
    Enum.map(points, &add_color(&1, color))
  end

  defp add_color({_x, _y, _c} = point, _color), do: point
  defp add_color({x, y}, color), do: {x, y, color}

  def to_string(points) do
    map =
      points
      |> Enum.map(fn key -> {key, "◼"} end)
      |> Map.new()

    for x <- 1..4, y <- 1..4 do
      Map.get(map, {x, y}, "◻")
    end
    |> Stream.chunk_every(4)
    |> Stream.map(&Enum.join/1)
    |> Enum.join("\n")
  end

  def print(points) do
    points
    |> __MODULE__.to_string()
    |> IO.puts()

    points
  end
end
