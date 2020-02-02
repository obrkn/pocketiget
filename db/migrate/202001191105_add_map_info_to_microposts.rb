class AddMapInfoToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :latitude, :float
    add_column :microposts, :longitude, :float
  end
end