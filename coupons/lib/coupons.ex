defmodule Coupons do


  use Application
  import Meeseeks.CSS


  def init(default_options) do
     IO.puts "initializing plug"
     default_options
  end

  def call(conn, options) do
     IO.puts "calling plug"
     conn
     |> Plug.Conn.put_resp_header("content-type", "text/html; charset=utf-8")
     |> Plug.Conn.send_file(200, "lib/web/couponsMain.html")
  end

  def start(_type, _args) do
      children = [
        Plug.Adapters.Cowboy.child_spec(:http, Web.Router, [], [port: 4001]),
        supervisor(Coupons.Repo, [])
      ]
      opts = [ strategy: :one_for_one, name: Coupons.Supervisor ]
      Supervisor.start_link(children, opts)
    end

#def start(_type, _args) do
#  import Supervisor.Spec
#
#  children = [
#    Coupons.Repo,
#  ]
#end


end
