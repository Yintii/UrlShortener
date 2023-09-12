class ShortLinksController < ApplicationController
  def home
    #if the user has submitted a link, generate a random hex and save it to the database
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

    if request.get?
      #if the user has entered a shortened link, redirect them to the original link
      if params[:short_link]
        #try catch block to catch any errors that may occur when saving to the database
        begin
          @db_entry = ShortLink.find_by(short_link: params[:short_link])
          #close db connection
          ActiveRecord::Base.connection.close
          redirect_to @db_entry.original_link
        rescue ActiveRecord::RecordNotFound => e
          #if the random hex is not unique, generate a new one and try again
          redirect_to root_path
          flash[:error] = "The link you entered does not exist"
        end
      end
    end
  end
end
