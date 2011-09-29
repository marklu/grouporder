class CreateRealms < ActiveRecord::Migration
  def change
    create_table :realms do |t|
      t.references :organization
      t.references :event
      t.references :coordinator
      t.string :token

      t.timestamps
    end
    add_index :realms, :organization_id
    add_index :realms, :event_id
    add_index :realms, :coordinator_id
  end
end
