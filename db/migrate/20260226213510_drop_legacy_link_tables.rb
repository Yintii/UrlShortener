class DropLegacyLinkTables < ActiveRecord::Migration[7.2]
  def up
    drop_table :shorten_links, if_exists: true
    drop_table :shortened_links, if_exists: true
  end

  def down
    # These tables are intentionally not recreated
  end
end