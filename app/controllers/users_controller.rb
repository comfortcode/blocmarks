class UsersController < ApplicationController
  
  def show
  # @user_bookmarks = current_user.topics.bookmarks
  @bookmarks = current_user.bookmarks
  @likes = current_user.likes
  end
  
end