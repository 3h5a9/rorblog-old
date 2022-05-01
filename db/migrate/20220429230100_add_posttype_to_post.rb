class AddPosttypeToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :posttype, :integer, default: 1
  end
end
