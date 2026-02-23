class ShortLink < ApplicationRecord
  belongs_to :user, optional: true
  has_many :link_clicks, dependent: :destroy

  def record_click!(ip_address:, referrer: nil, user_agent: nil)
    link_clicks.create!(
      ip_address: ip_address,
      referrer: referrer,
      user_agent: user_agent,
      clicked_at: Time.current
    )
    increment!(:click_count)
  end
end
