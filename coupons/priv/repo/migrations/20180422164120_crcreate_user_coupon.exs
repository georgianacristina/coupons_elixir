defmodule Coupons.Repo.Migrations.CreateUserCoupon do
  use Ecto.Migration

  def change do

	 create table(:user_coupon) do
      add :giver_id, :integer
      add :receiver_id, :integer
      add :name, :string
      add :description, :string
      add :photo, :binary
    end
  end
end
