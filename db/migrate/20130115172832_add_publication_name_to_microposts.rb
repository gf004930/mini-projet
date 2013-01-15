class AddPublicationNameToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :publication_name, :string
  end
end
