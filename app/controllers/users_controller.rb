class UsersController < ApplicationController
  
  def show
  @bookmarks = current_user.bookmarks
  @likes = current_user.likes
  end
  
end