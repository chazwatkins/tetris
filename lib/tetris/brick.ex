defmodule Tetris.Brick do
  defstruct name: :i,
            location: {40, 0},
            rotation: 0,
            reflection: false

  def new(), do: __struct__()

  def new_random() do
    %__MODULE__{
      name: random_name(),
      location: {40, 0},
      rotation: random_rotation(),
      reflection: random_reflection()
    }
  end

  def random_name(), do: Enum.random(~w(i l z o t)a)

  def random_rotation(), do: Enum.random([0, 90, 180, 270])

  def random_reflection(), do: Enum.random([true, false])

  def left(brick) do
    %{brick | location: point_left(brick.location)}
  end

  def right(brick) do
    %{brick | location: point_right(brick.location)}
  end

  def down(brick) do
    %{brick | location: point_down(brick.location)}
  end

  def point_left({x, y}), do: {x - 1, y}

  def point_right({x, y}), do: {x + 1, y}

  def point_down({x, y}), do: {x, y + 1}

  def spin_90(brick) do
    %{brick | rotation: rotate(brick.rotation)}
  end

  def rotate(270), do: 0
  def rotate(degrees), do: degrees + 90
end
