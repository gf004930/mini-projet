class AddMonthToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :month, :integer
  end
end
