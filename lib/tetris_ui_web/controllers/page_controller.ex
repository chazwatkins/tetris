defmodule TetrisUIWeb.PageController do
  use TetrisUIWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
