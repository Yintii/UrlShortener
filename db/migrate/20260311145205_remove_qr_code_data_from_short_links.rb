class RemoveQrCodeDataFromShortLinks < ActiveRecord::Migration[7.2]
  def change
    remove_column :short_links, :qr_code_data, :text
  end
end
