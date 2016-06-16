class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.integer :amount, default: 0
      t.integer :blog_id
      t.timestamps null: false
    end
  end
end
