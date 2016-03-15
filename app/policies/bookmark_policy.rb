class BookmarkPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record.topic
  end

  def create?
   user.present? && (record.user == user)
  end
  
end