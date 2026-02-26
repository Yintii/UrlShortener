class AddLocationToLinkClicks < ActiveRecord::Migration[7.2]
  def change
    add_column :link_clicks, :country, :string
    add_column :link_clicks, :region, :string
    add_column :link_clicks, :city, :string
    add_column :link_clicks, :latitude, :float
    add_column :link_clicks, :longitude, :float
  end
end
