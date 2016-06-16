# == Schema Information
#
# Table name: accesses
#
#  id         :integer          not null, primary key
#  amount     :integer          default(0)
#  blog_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Access < ActiveRecord::Base
  belongs_to :blog
end
