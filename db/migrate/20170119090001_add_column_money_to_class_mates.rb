class AddColumnMoneyToClassMates < ActiveRecord::Migration[5.0]
  def change
    add_column :class_mates, :money, :integer
  end
end
