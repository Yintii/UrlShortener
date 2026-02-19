class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:profile]
  


  def profile
    @user = current_user
    @short_links = @user.short_links
  end
end
