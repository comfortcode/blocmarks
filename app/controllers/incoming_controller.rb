class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]


  def create

    sender = User.find_by(email: params[:sender])

    if sender.present?
        
        # create or find the topic...
        topic = Topic.create_with(user: sender).find_or_create_by(title: params[:subject])

        # create and save the bookmark...
        new_bookmark = topic.bookmarks.new(url: params[:'stripped-text'])
    
        if new_bookmark.save
            puts "New email bookmark was saved. Sender #{sender.email}, Topic: #{topic.title}, New_Bookmark: #{new_bookmark.url}"
        else 
            puts "There was an error saving the bookmark. Sender #{sender.email}, Topic: #{topic.title}, New_Bookmark: #{new_bookmark.url}"
        end
    else
        puts "There was an error saving the bookmark as the sender #{params[:sender]} was not a found user. Subject: #{params[:subject]}, Body: #{params[:'stripped-text']}"
    end 

    head 200
  end
end