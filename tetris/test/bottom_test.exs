defmodule Tetris.BottomTest do
  use ExUnit.Case

  import Tetris.Bottom

  setup do
    bottom = %{{1, 1} => {1, 1, :blue}}
    {:ok, bottom: bottom}
  end

  test "various collisions", %{bottom: bottom} do
    bottom
    |> assert_collides({1, 1}, true)
    |> assert_collides({1, 2}, false)
    |> assert_collides({1, 1, :red}, true)
    |> assert_collides({1, 3, :red}, false)
  end

  test "points can merge into the bottom", %{bottom: bottom} do
    actual = merge(bottom, [{1, 2, :red}, {1, 3, :red}])

    expected = %{
      {1, 1} => {1, 1, :blue},
      {1, 2} => {1, 2, :red},
      {1, 3} => {1, 3, :red}
    }

    assert actual == expected
  end

  def assert_collides(bottom, point, expected) do
    assert collides?(bottom, point) == expected
    bottom
  end
end
