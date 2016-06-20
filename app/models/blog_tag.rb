# == Schema Information
#
# Table name: blog_tags
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  blog_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BlogTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :blog
end
