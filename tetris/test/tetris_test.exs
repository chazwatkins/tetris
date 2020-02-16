defmodule TetrisTest do
  use ExUnit.Case
  import Tetris

  alias Tetris.Brick

  test "try to move, successfully" do
    brick = Brick.new(location: {5, 1})
    bottom = %{}

    brick
    |> assert_move(bottom, &try_right/2, Brick.right(brick))
    |> assert_move(bottom, &try_left/2, Brick.left(brick))
    |> assert_move(bottom, &try_spin_90/2, Brick.spin_90(brick))
  end

  test "try to move, unsuccessfully and returns original brick" do
    brick = Brick.new(location: {8, 1})
    bottom = %{}

    assert_move(brick, bottom, &try_right/2, brick)
  end

  test "drops without merging" do
    brick = Brick.new(location: {5, 5})
    bottom = %{}

    expected = %{
      brick: Brick.down(brick),
      bottom: %{},
      score: 0
    }

    actual = drop(brick, bottom, :red)

    assert actual == expected
  end

  test "drops and merges" do
    brick = Brick.new(location: {5, 16})
    bottom = %{}

    expected = {7, 20, :red}
    actual = drop(brick, bottom, :red)

    assert Map.get(actual.bottom, {7, 20}) == expected
  end

  def assert_move(brick, bottom, f, expected) do
    assert f.(brick, bottom) == expected
    brick
  end
end
