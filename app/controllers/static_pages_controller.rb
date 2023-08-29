class StaticPagesController < ApplicationController
  def Home
    #on post request, take the data from the form and save it to the database
    #with an new, asscoiated, shortened link that the given link will 301 redirect to
    if request.post?
      
      #add a timestamp to the users session,
      #only allow the user to shorten a link every 5 seconds
      #and only allow the user to shorten 10 links per minute
      #and only allow the user to shorten 20 links per hour
      #and only allow the user to shorten 50 links per day
 

      @short_link = SecureRandom.hex(3)
      
      #the shortened link model is used to store the shortened link and the original link
      @db_entry = ShortLink.new(original_link: params[:link], short_link: @short_link)

      #if the data is valid, save it to the database
      if @db_entry.valid?
       
        #if the user has not shortened a link before, create a new session
        if session[:links_created] == nil
          session[:links_created] = 0
          session[:last_shorten] = Time.now
        end

        #check how many links the user already has shortened and in what time inervals
        #if the user has shortened more than 50 links in the last day, redirect to the home page
        if session[:links_created] > 50
          redirect_to root_path
          flash[:notice] = "You have shortened too many links today, please try again tomorrow"
        end

        #if the user has shortened more than 20 links in the last hour, redirect to the home page
        if session[:links_created] > 20 && session[:last_shorten] > 1.hour.ago
          redirect_to root_path
          flash[:notice] = "You have shortened too many links this hour, please try again later"
        end

        #if the user has shortened more than 10 links in the last minute, redirect to the home page
        if session[:links_created] > 10 && session[:last_shorten] > 1.minute.ago
          redirect_to root_path
          flash[:notice] = "You have shortened too many links this minute, please try again later"
        end

        #if the user has shortened a link in the last 5 seconds, redirect to the home page
        if session[:last_shorten] > 5.seconds.ago
          redirect_to root_path
          flash[:notice] = "You have shortened a link too recently, please try again later"
        end
      

        #save the shortened link to the database
        
        @db_entry.save
        session[:links_created] = session[:links_created] + 1
        #if the user has not shortened a link before, create a new session
        if session[:last_shorten] == nil
          session[:last_shorten] = Time.now
        end
      end
      #if the data is not valid, redirect to the home page
    end
  end

  def About
  end
end
