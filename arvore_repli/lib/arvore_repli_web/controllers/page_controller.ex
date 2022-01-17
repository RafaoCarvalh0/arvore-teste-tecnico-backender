defmodule ArvoreRepliWeb.PageController do
  use ArvoreRepliWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
