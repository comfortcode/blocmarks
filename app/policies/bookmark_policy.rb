class BookmarkPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record.topic
  end
end