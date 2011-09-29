class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :event
      t.string :name

      t.timestamps
    end
    add_index :options, :event_id
  end
end
