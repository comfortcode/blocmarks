class LikesController < ApplicationController
    
    def new
    end 

   def create
     @bookmark = Bookmark.find(params[:bookmark_id])
     like = current_user.likes.build(bookmark: @bookmark)
 
     if like.save
       flash[:notice] = "You liked #{@bookmark.url}!"
     else
        flash[:error] = "There was an error liking #{@topic.url}. Please try again"
     end
    redirect_to @bookmark
   end

   def destroy
     @bookmark = Bookmark.find(params[:bookmark_id])
     @like = Like.find(params[:id])
 
     if @like.destroy
       flash[:notice] = "You unliked #{@bookmark.url}!"
     else
        flash[:error] = "There was an error unliking #{@topic.url}. Please try again"
     end
    redirect_to @bookmark
   end    
end
