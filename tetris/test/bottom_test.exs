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

  test "compute complete ys" do
    bottom = new_bottom(20, [{{19, 19}, {19, 19, :red}}])

    assert complete_ys(bottom) == [20]
  end

  test "collapse single row" do
    row = 20
    bottom = new_bottom(row, [{{19, 19}, {19, 19, :red}}])

    actual =
      bottom
      |> collapse_row(row)
      |> Map.keys()

    refute {19, 19} in actual
    assert {19, row} in actual
    assert Enum.count(actual) == 1
  end

  test "full collapse with single row" do
    row = 20
    bottom = new_bottom(row, [{{19, 19}, {19, 19, :red}}])

    {actual_count, actual_bottom} = full_collapse(bottom)

    assert actual_count == 1
    assert {19, 20} in Map.keys(actual_bottom)
  end

  def new_bottom(complete_row, extras) do
    new_extras =
      1..10
      |> Enum.map(fn x ->
        {{x, complete_row}, {x, complete_row, :red}}
      end)

    Map.new(extras ++ new_extras)
  end

  def assert_collides(bottom, point, expected) do
    assert collides?(bottom, point) == expected
    bottom
  end
end
