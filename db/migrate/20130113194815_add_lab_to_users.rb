class AddLabToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lab, :string
  end
end
