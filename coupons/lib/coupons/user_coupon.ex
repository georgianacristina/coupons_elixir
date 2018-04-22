defmodule Coupons.UserCoupon do
  use Ecto.Schema

  schema "user_coupon" do
    field :giver_id, :integer
      field :receiver_id, :integer
      field :name, :string
      field :description, :string
      field :photo, :binary
  end
end