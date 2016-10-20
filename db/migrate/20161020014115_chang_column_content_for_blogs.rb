class ChangColumnContentForBlogs < ActiveRecord::Migration[5.0]
  def change
    change_column :blogs, :content, :text
  end
end
