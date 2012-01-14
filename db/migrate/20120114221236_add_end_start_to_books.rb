class AddEndStartToBooks < ActiveRecord::Migration
  def change
    add_column :books, :started_at, :datetime
    add_column :books, :finished_at, :datetime
  end
end
