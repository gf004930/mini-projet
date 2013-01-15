class AddNotesToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :notes, :string
  end
end
