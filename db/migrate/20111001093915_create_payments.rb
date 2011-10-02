class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :realm
      t.references :order
      t.decimal :amount, :precision => 10, :scale => 2
      t.string :description
      t.integer :checkout_id

      t.timestamps
    end
    add_index :payments, :realm_id
    add_index :payments, :order_id
  end
end
