defmodule TetrisUIWeb.TetrisLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    tetromino =
      Tetris.Brick.new_random()
      |> Tetris.Brick.to_string()

    {:ok, assign(socket, tetromino: tetromino)}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~L"""
    <pre><%= @tetromino %></pre>
    """
  end
end
