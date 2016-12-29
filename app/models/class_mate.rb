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
#

class ClassMate < ApplicationRecord


  def hide
    name[0] = '*'
    tel[3, 4] = '****'
    self
  end

end
