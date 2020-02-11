defmodule Tetris.BrickTest do
  use ExUnit.Case

  import Tetris.Brick
  alias Tetris.Points

  test "Creates a new brick" do
    assert new_brick().name == :i
  end

  test "Creates a new random brick" do
    actual = new_random()

    assert actual.name in [:i, :l, :z, :t, :o]
    assert actual.rotation in [0, 90, 180, 270]
    assert actual.reflection in [true, false]
  end

  test "should manipulate brick" do
    actual =
      new_brick()
      |> left()
      |> right()
      |> right()
      |> down()
      |> spin_90()
      |> spin_90()

    assert actual.location == {41, 1}
    assert actual.rotation == 180
  end

  test "should return points for i shape" do
    points =
      new_brick(name: :i)
      |> shape()

    assert {2, 2} in points
  end

  test "should return points for o shape" do
    points =
      new_brick(name: :o)
      |> shape()

    assert {3, 3} in points
  end

  test "should translate a list of points" do
    actual_points =
      new_brick()
      |> shape()
      |> Points.move_to_location({1, 1})
      |> Points.move_to_location({0, 1})

    assert actual_points == [{2, 4}, {3, 4}, {4, 4}, {5, 4}]
  end

  test "should flip rotate flip and mirror" do
    [{1, 1}]
    |> Points.mirror()
    |> assert_point({4, 1})
    |> Points.flip()
    |> assert_point({4, 4})
    |> Points.rotate_90()
    |> assert_point({1, 4})
    |> Points.rotate_90()
    |> assert_point({1, 1})
  end

  def new_brick(attributes \\ []), do: new(attributes)

  def assert_point([actual] = points, expected) do
    assert actual == expected
    points
  end
end
