# == Schema Information
#
# Table name: blogs
#
#  id          :integer          not null, primary key
#  category_id :integer          not null
#  title       :string(255)      not null
#  content     :string(255)      not null
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Blog < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :category
  has_many :accesses
  has_many :blog_tags
  has_many :tags, through: :blog_tags
  validates :title, :category_id, :content, presence: true

  class << self
    def get_conditions params
      search = [' 1 = 1 ']
      arr = [[]]
      if params[:search].present?
        search << ' blogs.title like ? '
        arr << "%#{params[:search]}%"
      end
      if params[:category].present?
        search << ' blogs.category_id  =  ? '
        arr << params[:category]
      end
      arr[0] = search.join 'and'
      arr.flatten
    end
  end

end
