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

        session[:first_shorten] ||= Time.now
        session[:links_created] ||= []
        if session[:last_shorten] == nil
          session[:last_shorten] ||= Time.now
        end

        #if the submited link is already in the session[:links_created] array, redirect to the home page
        #check if the submitted link is already in the session[:links_created] array
        if session[:links_created].any? {|link| link.has_key?(params[:link])}
          #if it is, find the shortened link associated with the submitted link
          #and redirect to the home page
          @short_link = session[:links_created].find {|link| link.has_key?(params[:link])}[params[:link]] 
          flash[:error] = "You have already shortened this link. We've provided it for you again below."
        end

        #check how many links the user already has shortened and in what time inervals
        #if the user has shortened more than 50 links in the last day, redirect to the home page
        #check if the length of session[:links_created] is greater than 50
        if session[:links_created].length > 50 && session[:first_shorten] > 1.day.ago
          redirect_to root_path
          flash[:error] = "You have shortened too many links today, please try again tomorrow"
        elsif session[:links_created].length > 20 && session[:first_shorten] > 1.hour.ago
          redirect_to root_path
          flash[:error] = "You have shortened too many links this hour, please try again later"
        elsif session[:links_created].length > 10 && session[:first_shorten] > 1.minute.ago
          redirect_to root_path
          flash[:notice] = "You have shortened too many links this minute, please try again later"
        elsif session[:last_shorten] > 5.seconds.ago
          redirect_to root_path
          flash[:notice] = "You have shortened a link too recently, please try again later"
        end
      
        puts "session[:links_created]: #{session[:links_created]}"


        #save the shortened link to the database
        
        @db_entry.save

        #add a hash of the shortened link and the associated @short_link to the session[:links_created] array
        session[:links_created] << {params[:link] => @short_link}


        session[:last_shorten] = Time.now
      end
    end
  end

  def About
  end
end
