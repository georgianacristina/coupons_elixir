defmodule Coupons do

	use Application
  def init(default_options) do
     IO.puts "initializing plug"
     default_options   
  end
  
  def call(conn, options) do
     IO.puts "calling plug"
     conn
     |> Plug.Conn.send_resp(200, "hello world")
  end


def start(_type, _args) do
  import Supervisor.Spec, warn: false

  children = [
    supervisor(Coupons.Repo, [])  ]

  opts = [ strategy: :one_for_one, name: Coupons.Supervisor ]
   Supervisor.start_link( children, opts )
end

end
