class AddWepayAccessTokenToEvent < ActiveRecord::Migration
  def change
    add_column :events, :wepay_access_token, :string
  end
end
