defmodule HousebookWeb.PageController do
  use HousebookWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
