class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :login, :null => false
      t.string  :crypted_password
      t.string  :password_salt
      t.string  :persistence_token

      t.timestamps
    end
  end
end
