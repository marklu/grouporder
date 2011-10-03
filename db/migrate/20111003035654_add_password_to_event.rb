class AddPasswordToEvent < ActiveRecord::Migration
  def change
    add_column :events, :password, :string
  end
end
