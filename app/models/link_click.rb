class LinkClick < ApplicationRecord
  belongs_to :short_link

  scope :unique_ips, -> { distinct.count(:ip_address) }
  scope :by_day, -> { group("DATE(clicked_at)").count }
  
  geocoded_by :ip_address
  after_create :geocode_location
  
  private

  def geocode_location
    result = Geocoder.search(ip_address).first
    return unless result

    update_columns(
      country: result.country,
      region: result.state,
      city: result.city,
      latitude: result.latitude,
      longitude: result.longitude
    )
  end
end