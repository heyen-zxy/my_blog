class CreateClassMates < ActiveRecord::Migration[5.0]
  def change
    create_table :class_mates do |t|
      t.string :name
      t.string :tel
      t.integer :number, default: 1
      t.timestamps
    end
  end
end
