class StaticPagesController < ApplicationController
  def Home
    #on post request, take the data from the form and save it to the database
    #with an new, asscoiated, shortened link that the given link will 301 redirect to
    if request.post?
      @short_link = SecureRandom.hex(3)

      #the shortened link model is used to store the shortened link and the original link
      
      @db_entry = ShortLink.new(original_link: params[:link], short_link: @short_link)

      #if the data is valid, save it to the database
      if @db_entry.valid?
        @db_entry.save
      end
      #if the data is not valid, redirect to the home page

    end


  end

  def About
  end
end
