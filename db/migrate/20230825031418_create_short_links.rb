class CreateShortLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :short_links do |t|
      t.string :original_link
      t.string :short_link

      t.timestamps
    end
  end
end
