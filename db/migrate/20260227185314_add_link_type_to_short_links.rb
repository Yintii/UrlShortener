class AddLinkTypeToShortLinks < ActiveRecord::Migration[7.2]
  def change
    add_column :short_links, :link_type, :string, default: "shrtn", null: false
    add_column :short_links, :qr_code_data, :text
    add_index :short_links, :link_type
  end
end