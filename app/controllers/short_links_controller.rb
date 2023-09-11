class ShortLinksController < ApplicationController
  def home
    if request.get?
    end

    if request.post?

      if params[:link] == ""
        redirect_to root_path
        flash[:error] = "You must enter a link to shorten"
      end


      @short_link = SecureRandom.hex(3)
      
      #the shortened link model is used to store the shortened link and the original link
      @db_entry = ShortLink.new(original_link: params[:link], short_link: @short_link)

      #if the data is valid, save it to the database
      if @db_entry.valid?
        #try catch block to catch any errors that may occur when saving to the database
        begin
          @db_entry.save
          #close db connection
          ActiveRecord::Base.connection.close
        rescue ActiveRecord::RecordNotUnique => e
          #if the random hex is not unique, generate a new one and try again
          @short_link = SecureRandom.hex(3)
          @db_entry.short_link = @short_link
          retry
        end
      end
    end
  end

  def redirect
    short_link = ShortLink.find_by(short_link: params[:short_link])
    if short_link
      redirect_to short_link.original_link, status: 301, allow_other_host: true
    else
      redirect_to root_path, alert: "Short link not found", status: 404
    end
  end
end
