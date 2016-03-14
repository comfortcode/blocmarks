class UsersController < ApplicationController
  
  def show
  # @user_bookmarks = current_user.topics.bookmarks
  @topics = current_user.topics
  @likes = current_user.likes
  end
  
end