defmodule Tetris do
  alias Tetris.{Brick, Bottom, Points}

  def prepare(brick) do
    brick
    |> Brick.prepare()
    |> Points.move_to_location(brick.location)
  end

  def try_move(brick, bottom, f) do
    new_brick = f.(brick)

    if Bottom.collides?(bottom, prepare(new_brick)) do
      brick
    else
      new_brick
    end
  end

  def drop(brick, bottom, color) do
    new_brick = Brick.down(brick)

    maybe_do_drop(
      Bottom.collides?(bottom, prepare(new_brick)),
      bottom,
      brick,
      new_brick,
      color
    )
  end

  def maybe_do_drop(true = _collided, bottom, old_brick, _new_brick, color) do
    points =
      old_brick
      |> prepare()
      |> Points.with_color(color)

    %{
      brick: Brick.new_random(),
      bottom: Bottom.merge(bottom, points),
      score: 100
    }
  end

  def maybe_do_drop(false = _collided, bottom, _old_brick, new_brick, _color) do
    %{
      brick: new_brick,
      bottom: bottom,
      score: 0
    }
  end

  def try_left(brick, bottom), do: try_move(brick, bottom, &Brick.left/1)
  def try_right(brick, bottom), do: try_move(brick, bottom, &Brick.right/1)
  def try_spin_90(brick, bottom), do: try_move(brick, bottom, &Brick.spin_90/1)
end
