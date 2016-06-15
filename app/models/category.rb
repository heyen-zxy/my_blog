class Category < ActiveRecord::Base
  acts_as_paranoid
  has_many :blogs
  validates :name, presence: true
end
