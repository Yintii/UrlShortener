class LinkClick < ApplicationRecord
  belongs_to :short_link

  scope :unique_ips, -> { distinct.count(:ip_address) }
  scope :by_day, -> { group("DATE(clicked_at)").count }
end