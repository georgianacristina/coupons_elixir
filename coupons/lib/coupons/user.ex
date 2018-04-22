defmodule Coupons.User do
  use Ecto.Schema

  schema "user" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string
  end
end