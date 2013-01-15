class AddPostTypeToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :post_type, :string
  end
end
