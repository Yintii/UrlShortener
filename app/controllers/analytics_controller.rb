class AnalyticsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_short_link
    
    def show
        @click_count = @short_link.click_count
        @unique_ips = @short_link.link_clicks.unique_ips
        @clicks_by_day = @short_link.link_clicks.by_day
    end
    
    def analytics
      @short_link = ShortLink.find(params[:id])
      @click_count = @short_link.link_clicks.count
      @unique_ips = @short_link.link_clicks.distinct.count(:ip_address)
      @clicks_by_day = @short_link.link_clicks.group_by_day(:clicked_at).count
      
      # For the map - only clicks that were successfully geocoded
      @click_locations = @short_link.link_clicks
                              .where.not(latitude: nil)
                              .select(:latitude, :longitude, :city, :country)
                              .map { |c| { lat: c.latitude, lng: c.longitude, city: c.city, country: c.country } } || []
    end
    
    
    private
    
    def set_short_link
        @short_link = current_user.short_links.find(params[:short_link_id])
    end
end