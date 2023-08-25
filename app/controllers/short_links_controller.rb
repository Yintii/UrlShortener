class ShortLinksController < ApplicationController

  def redirect
    short_link = ShortLink.find_by(short_link: params[:short_link])
    if short_link
      redirect_to short_link.original_link, status: 301, allow_other_host: true
    else
      redirect_to root_path, alert: "Short link not found", status: 404
    end
  end
  
end
