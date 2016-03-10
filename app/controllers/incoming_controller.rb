class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create

    sender = User.find_by(email: params[:sender])

    if sender.present?
        
        topic = sender.topics.find_by(title: params[:subject])
    
        if topic.nil? # need to create new topic...
            topic = sender.topics.new(title: params[:subject])
        end 
        
        new_bookmark = topic.bookmarks.new(url: params[:'stripped-text'])
    
        if new_bookmark.save
            puts "New email bookmark was saved. Sender #{sender.email}, Topic: #{topic.title}, New_Bookmark: #{new_bookmark.url}"
        else 
            puts "There was an error saving the bookmark. Sender #{sender.email}, Topic: #{topic.title}, New_Bookmark: #{new_bookmark.url}"
        end
    end 

     # You put the message-splitting and business
     # magic here.
     # Find the user by using params[:sender]
     # Find the topic by using params[:subject]
     # Assign the url to a variable after retreiving it from params["body-plain"]

     # Check if user is nil, if so, create and save a new user

     # Check if the topic is nil, if so, create and save a new topic

     # Now that you're sure you have a valid user and topic, build and save a new bookmark

    # Assuming all went well.
    head 200
  end
end