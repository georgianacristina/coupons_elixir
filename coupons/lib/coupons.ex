defmodule Coupons do


  use Application


  def init(default_options) do
     IO.puts "initializing plug"
     default_options
  end

  def call(conn, options) do
     IO.puts "calling plug"
     Web.Router.call(conn, Web.Router.init([]))
  end

  def start(_type, _args) do
     import Supervisor.Spec, warn: false

      children = [
        Plug.Adapters.Cowboy.child_spec(:http, Web.Router, [], [port: 4001]),
        supervisor(Coupons.Repo, [])
      ]
      opts = [ strategy: :one_for_one, name: Coupons.Supervisor ]
      Supervisor.start_link(children, opts)
    end

end

defmodule CouponsList.Page do
    import Plug.Conn

    def render(conn, controller) do
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
        "</br><strong>Description:</strong> " <> Kernel.inspect(n.description) <> "<hr>"
        html = Enum.join([header_html, x], " ")
        html = Enum.join([html, footer_html], " ")
        conn
        |> put_resp_content_type("text/html")
        |> send_resp(200,  html)
    end
end
