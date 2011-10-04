class AddLimitToOptions < ActiveRecord::Migration
  def change
    add_column :options, :limit, :integer
  end
end
