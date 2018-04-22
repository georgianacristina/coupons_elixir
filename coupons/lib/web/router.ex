defmodule Web.Router do
  use Plug.Router

  plug :match
  plug :dispatch


	get "/" do
	  conn
     |> Plug.Conn.put_resp_header("content-type", "text/html; charset=utf-8")
     |> Plug.Conn.send_file(200, "lib/web/couponsMain.html")
	end

  get "/elixir" do
    send_resp(conn, 200, "I love <3 Elixir")
  end

  get "/coupons" do
    [controller] = ["page"]
    CouponsList.Page.render(conn, controller)
  end

  match _ do
    send_resp(conn, 404, "This is not the page you're looking for.")
  end

end
