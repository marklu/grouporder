class CreateRealms < ActiveRecord::Migration
  def change
    create_table :realms do |t|
      t.references :organization
      t.references :event
      t.string :token
	  t.string :admin_token

      t.timestamps
    end
    add_index :realms, :organization_id
    add_index :realms, :event_id
  end
end
