class CreateCheckoutReferences < ActiveRecord::Migration
  def change
    create_table :checkout_references do |t|
      t.references :realm
      t.text :comment
      t.integer :checkout_id

      t.timestamps
    end
    add_index :checkout_references, :realm_id
  end
end
