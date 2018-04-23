defmodule Coupons do

  use Application

  def init(default_options) do
     IO.puts "initializing plug"
     default_options
  end

  def call(conn, options) do
     IO.puts "calling plug"
     Web.Router.call(conn, Web.Router.init([]))
     conn
     |> Plug.Conn.put_resp_header("content-type", "text/html; charset=utf-8")
     |> Plug.Conn.send_file(200, "lib/web/couponsMain.html")
  end

  def start(_type, _args) do
     import Supervisor.Spec, warn: false

      children = [
        Plug.Adapters.Cowboy.child_spec(:http, Web.Router, [], [port: 4002]),
        supervisor(Coupons.Repo, [])
      ]
      opts = [ strategy: :one_for_one, name: Coupons.Supervisor ]
      Supervisor.start_link(children, opts)
    end

end

defmodule CouponsList.Page do
    import Plug.Conn

    def render(conn, controller) do
      conn = assign(conn, :current_user, conn.assigns.current_user)
      user_id =  conn.assigns.current_user.id
        header_html = "
        <!DOCTYPE html>
        <html>
            <head>
                <title>Coupons</title>
            </head>
            <body>
                <h1>Coupons</h1>
                <p>All coupons added by users are displayed on this page.</p>
        "
        footer_html = "
             </body>
        </html>
        "
        x = for n <- Coupons.UserCoupon |> Coupons.Repo.all, do:
        "</br><strong>ID:</strong> " <> Kernel.inspect(n.id) <>
        "</br><strong>Name:</strong> " <> Kernel.inspect(n.name) <>
        "</br><strong>Description:</strong> " <> Kernel.inspect(n.description) <> 
        "</br><button onclick=\"window.location.href='/addcoupon?giver_id=" <>  Kernel.inspect(n.giver_id) 
              <> "&user_id=" <> Kernel.inspect(user_id) <> "&coupon_id=" 
              <> Kernel.inspect(n.id)  <> "'\">Get this coupon</button>" <> "<hr>"
        
        html = Enum.join([header_html, x], " ")
        html = Enum.join([html, footer_html], " ")

        conn
        |> put_resp_content_type("text/html")
        |> send_resp(200,  html)

    end
end

defmodule Login.Page do
    import Plug.Conn
     require Ecto.Query

    def parse(conn, opts \\ []) do
	    opts = Keyword.put_new(opts, :parsers, [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
	    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
	end

    def render(conn, controller) do
       	conn = parse(conn)
		email = conn.params["email"]
		password = conn.params["password"] 
		user = Ecto.Query.from(p in Coupons.User, where: p.email == ^email,  where: p.password == ^password) |> Coupons.Repo.one
		if !!user do
      conn = assign(conn, :current_user, user)
		[controller] = ["coupons"]
	    CouponsList.Page.render(conn, controller)
		

			# conn = %{conn | path_info: ["coupons"]}
			# send_resp(conn, 200, "")

			    # Invoke the plug
			    # conn = Web.Router.call(conn, Web.Router.init([]))
		else
			send_resp(conn, 200, "#{email} doesn't exist.")
		end
    end
end

defmodule Register.Page do
    import Plug.Conn

    def parse(conn, opts \\ []) do
	    opts = Keyword.put_new(opts, :parsers, [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
	    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
	end

    def render(conn, controller) do
       	conn = parse(conn)
		email = conn.params["email"]
		password = conn.params["password"]
		firstName = conn.params["first_name"]
		lastName = conn.params["last_name"]
		user = %Coupons.User{email: email, password: password, first_name: firstName, last_name: lastName}
		case Coupons.Repo.insert(user) do
		  {:ok, user}       ->
		  	conn = assign(conn, :current_user, user)
        [controller] = ["coupons"]
      CouponsList.Page.render(conn, controller)
		  {:error, user} ->
		  	send_resp(conn, 200, "Something went wrong.")
		end
    end
end

defmodule CouponInsert.Page do
    import Plug.Conn

    def parse(conn, opts \\ []) do
	    opts = Keyword.put_new(opts, :parsers, [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
	    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
	  end

    def render(conn, controller) do

      IO.puts conn.assigns.current_user.id
       	conn = parse(conn)
		name = conn.params["name"]
		description = conn.params["description"]
		photo = conn.params["photo"]
		# IO.puts conn
		# receiverId = conn.params[""]
		# coupon = %Coupons.UserCoupon{name: name, description: description, photo: photo, receiver_id: iddd, giver_id: iddd}
		# case Coupons.Repo.insert(coupon) do
		#   {:ok, coupon}       -> 
		#   	send_resp(conn, 200, "Succesfully inserted.")
		#   {:error, user} ->
		#   	send_resp(conn, 200, "Something went wrong.")
		# end
    end
end
