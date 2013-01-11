class AddVisibleToBooks < ActiveRecord::Migration
  def change
    add_column :books, :visible, :boolean, :default => true

  end
end
