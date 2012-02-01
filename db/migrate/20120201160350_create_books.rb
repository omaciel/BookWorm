class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :pages
      t.string :status
      t.date :started_at
      t.date :finished_at
      t.integer :user_id

      t.timestamps
    end
  end
end
