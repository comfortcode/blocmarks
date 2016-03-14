class BookmarkPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record.topic
  end
  
 # Why doesn't this rule work? I want users to create new bookmarks only if the topic belongs to that user
 # (Authorizing @topic in Bookmarks#Create doesn't work either. Why not? Is that because Topics can be created ny any user?)
  def create?
   user.present? && (record.user == user)
  end
  
end