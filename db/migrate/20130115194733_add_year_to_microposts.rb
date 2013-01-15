class AddYearToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :year, :integer
  end
end
