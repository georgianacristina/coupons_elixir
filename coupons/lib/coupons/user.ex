defmodule Coupons.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string
  end

  def changeset(user, params \\ %{}) do
  	user
  	|> Ecto.Changeset.cast(params, [:first_name, :last_name, :email, :password])
  	|> Ecto.Changeset.validate_required([:first_name, :last_name])
  end
end