defmodule Coupons.UserCoupon do
  use Ecto.Schema

  schema "user_coupon" do
    field :giver_id, :integer
      field :receiver_id, :integer
      field :name, :string
      field :description, :string
      field :photo, :binary
  end


  def changeset(coupon, params \\ %{}) do
	  coupon
	  |> Ecto.Changeset.cast(params, [:giver_id, :receiver_id, :name, :description, :photo])
	  |> Ecto.Changeset.validate_required([:name])
	end
end