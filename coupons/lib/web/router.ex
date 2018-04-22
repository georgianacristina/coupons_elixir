defmodule Web.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/elixir" do
    send_resp(conn, 200, "I love <3 Elixir")
  end

  match _ do
    send_resp(conn, 404, "This is not the page you're looking for.")
  end

end
