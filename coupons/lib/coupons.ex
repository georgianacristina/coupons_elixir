defmodule Coupons do
  def init(default_options) do
     IO.puts "initializing plug"
     default_options   
  end
  
  def call(conn, options) do
     IO.puts "calling plug"
     conn
     |> Plug.Conn.send_resp(200, "hello world")
  end
end
