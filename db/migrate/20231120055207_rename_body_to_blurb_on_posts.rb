class RenameBodyToBlurbOnPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :body, :blurb
  end
end
