# == Schema Information
#
# Table name: blogs
#
#  id          :integer          not null, primary key
#  category_id :integer          not null
#  title       :string           not null
#  content     :string           not null
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Blog < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :category
  has_many :accesses
  validates :title, :category_id, :content, presence: true
end
