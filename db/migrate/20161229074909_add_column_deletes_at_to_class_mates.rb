class AddColumnDeletesAtToClassMates < ActiveRecord::Migration[5.0]
  def change
    add_column :class_mates, :deleted_at, :datetime
  end
end
