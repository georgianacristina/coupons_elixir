defmodule Web.Router do
  use Plug.Router

  plug :match
  plug :dispatch

	def parse(conn, opts \\ []) do
	    opts = Keyword.put_new(opts, :parsers, [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
	    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
	end

	get "/" do
	  conn
     |> Plug.Conn.put_resp_header("content-type", "text/html; charset=utf-8")
     |> Plug.Conn.send_file(200, "lib/web/couponsMain.html")
	end

	get "/login" do
	  conn
     |> Plug.Conn.put_resp_header("content-type", "text/html; charset=utf-8")
     |> Plug.Conn.send_file(200, "lib/web/login.html")
	end

	get "/register" do
	  conn
     |> Plug.Conn.put_resp_header("content-type", "text/html; charset=utf-8")
     |> Plug.Conn.send_file(200, "lib/web/register.html")
	end

	get "/addcoupon/:giver_id" do
	  conn
     |> Plug.Conn.put_resp_header("content-type", "text/html; charset=utf-8")
     |> Plug.Conn.send_file(200, "lib/web/add_coupon.html")
	end


	get "/coupons" do
	    [controller] = ["page"]
	    CouponsList.Page.render(conn, controller)
	end

	post "/addcoupon" do
	    [controller] = ["page"]
	    CouponInsert.Page.render(conn, controller)
	end

	post "/login" do
		[controller] = ["page"]
	    Login.Page.render(conn, controller)
	end

	post "/register" do
		[controller] = ["page"]
	    Register.Page.render(conn, controller)
	end

	match _ do
		send_resp(conn, 404, "This is not the page you're looking for.")
	end


end
