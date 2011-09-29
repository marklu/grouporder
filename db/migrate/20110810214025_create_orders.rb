class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :realm
      t.string :name
      t.references :option
      t.datetime :timestamp

      t.timestamps
    end
    add_index :orders, :realm_id
    add_index :orders, :option_id
  end
end
