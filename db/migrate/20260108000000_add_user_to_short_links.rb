class AddUserToShortLinks < ActiveRecord::Migration[7.2]
  def change
    add_reference :short_links, :user, foreign_key: true, null: true
  end
end
