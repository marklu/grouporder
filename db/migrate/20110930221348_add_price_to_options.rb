class AddPriceToOptions < ActiveRecord::Migration
  def change
    add_column :options, :price, :decimal, :precision => 10, :scale => 2
  end
end
