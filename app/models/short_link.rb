class ShortLink < ApplicationRecord
  scope :shortened, -> { where(link_type: "shrtn") }
  scope :qr_codes,  -> { where(link_type: "qr") }
  belongs_to :user, optional: true
  has_many :link_clicks, dependent: :destroy
  validates :original_link, format: {
    with: /\Ahttps?:\/\/.+\z/,
    message: "must be a valid http or https URL"
  }

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
