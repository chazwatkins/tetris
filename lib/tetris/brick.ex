defmodule Tetris.Brick do
  defstruct name: :i,
            location: {40, 0},
            rotation: 0,
            reflection: false

  def new(), do: __struct__()

  def new_random() do
    %{
      name: random_name(),
      location: {40, 0},
      rotation: random_rotation(),
      reflection: random_reflection()
    }
  end

  def random_name(), do: Enum.random(~w(i l z o t)a)

  def random_rotation(), do: Enum.random([0, 90, 180, 270])

  def random_reflection(), do: Enum.random([true, false])
end
