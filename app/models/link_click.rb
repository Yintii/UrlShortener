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
  
    lat, lng = result.data["loc"]&.split(",")&.map(&:to_f)
    return unless lat && lng
  
    update_columns(
      country: result.data["country"],
      region: result.data["region"],
      city: result.data["city"],
      latitude: lat,
      longitude: lng
    )
  end
end