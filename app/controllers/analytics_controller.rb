class AnalyticsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_short_link
    
    def show
        @click_count = @short_link.click_count
        @unique_ips = @short_link.link_clicks.unique_ips
        @clicks_by_day = @short_link.link_clicks.by_day
    end
    
    private
    
    def set_short_link
        @short_link = current_user.short_links.find(params[:short_link_id])
    end
end