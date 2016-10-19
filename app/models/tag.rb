# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  has_many :blog_tags, dependent: :destroy
  has_and_belongs_to_many :blogs, join_table: :blog_tags
end
