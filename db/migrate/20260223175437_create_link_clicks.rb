class CreateLinkClicks < ActiveRecord::Migration[7.2]
  def change
    create_table :link_clicks do |t|
      t.references :short_link, null: false, foreign_key: true
      t.string :ip_address
      t.string :user_agent
      t.string :referrer
      t.datetime :clicked_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end

    add_index :link_clicks, :clicked_at
  end
end