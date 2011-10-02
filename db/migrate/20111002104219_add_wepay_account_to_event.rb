class AddWepayAccountToEvent < ActiveRecord::Migration
  def change
    add_column :events, :wepay_account, :integer
  end
end
