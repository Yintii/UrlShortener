class ShortLinksController < ApplicationController
  def home
    #if the user has submitted a link, generate a random hex and save it to the database
    if request.post?

      if params[:link] == ""
        redirect_to root_path
        flash[:error] = "You must enter a link to shorten"
      end

      @short_link = SecureRandom.hex(3)
      
      @db_entry = ShortLink.new(original_link: params[:link], short_link: @short_link)
      @db_entry.user = current_user if user_signed_in?

      if @db_entry.valid?
        begin
          @db_entry.save
          ActiveRecord::Base.connection.close
        rescue ActiveRecord::RecordNotUnique => e
          #if the random hex is not unique, generate a new one and try again
          @short_link = SecureRandom.hex(3)
          @db_entry.short_link = @short_link
          retry
        end
      end
    end #end if request.post?

    if request.get?
      #if the user has entered a shortened link, redirect them to the original link
      if params[:short_link]
        #try catch block to catch any errors that may occur when searching the database
        begin
          @db_entry = ShortLink.find_by(short_link: params[:short_link])
          ActiveRecord::Base.connection.close
          redirect_to @db_entry.original_link, status: 301, allow_other_host: true
        rescue ActiveRecord::RecordNotFound => e
          #if the random hex is not found, redirect to the home page and display an error
          redirect_to root_path
          flash[:error] = "The link you entered does not exist"
        end
      end
    end #end if request.get?

  end #end home
end
