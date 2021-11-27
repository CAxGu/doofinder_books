defmodule DoofinderBooksWeb.ReadController do
  use DoofinderBooksWeb, :controller

  def read(conn, _params) do
    render(conn, "read.html")
  end
end
