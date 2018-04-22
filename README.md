# coupons_elixir

# Install

Install dependecies:

	mix deps.get

Compile:

	iex -S mix

When prompt 'iex(1)>' appears, write:

	Plug.Adapters.Cowboy.http(Coupons, [])

Server should be available at http://0.0.0.0:4000/


# Databse

Go to /config/confix.exs and change "username" and "password" with the "username" and "password" from PostrgeSQL.
