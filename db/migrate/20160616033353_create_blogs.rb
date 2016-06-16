class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :category_id, null: false
      t.string :title, null: false
      t.string :content, null: false
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
