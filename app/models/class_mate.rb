# == Schema Information
#
# Table name: class_mates
#
#  id         :integer          not null, primary key
#  name       :string
#  tel        :string
#  number     :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  money      :integer
#

class ClassMate < ApplicationRecord
  acts_as_paranoid

  def hide
    name[0] = '*' if name.present?
    tel[3, 4] = '****' if tel.present?
    self
  end

end
