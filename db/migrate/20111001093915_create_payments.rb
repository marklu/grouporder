class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :realm
      t.decimal :amount, :precision => 10, :scale => 2
      t.string :comment

      t.timestamps
    end
    add_index :payments, :realm_id
  end
end
