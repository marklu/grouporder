class CreateOrderOptions < ActiveRecord::Migration
  def change
    create_table :order_options do |t|
      t.references :realm
      t.string :name

      t.timestamps
    end
    add_index :order_options, :realm_id
  end
end
