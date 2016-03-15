class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
    @like = Like.new
    authorize @bookmark
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new
    authorize @bookmark
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(params.require(:bookmark).permit(:url))
    authorize @bookmark
    if @bookmark.save
      flash[:notice] = "Bookmark was saved"
      redirect_to topic_show_path({
        title: @topic.title
      })
    else 
      flash[:error] = "There was an error saving the bookmark. Please try again"
      render :new
    end 
  end 

   def edit
       @bookmark = Bookmark.find(params[:id])
        authorize @bookmark
     end
  
   def update
       @bookmark = Bookmark.find(params[:id])
        authorize @bookmark
       if @bookmark.update_attributes(params.require(:bookmark).permit(:url))
         flash[:notice] = "Bookmark was updated."
         redirect_to [@bookmark.topic, @bookmark]
       else
         flash[:error] = "There was an error saving the bookmark. Please try again."
         render :edit
       end
     end  
     
   def destroy
     @bookmark = Bookmark.find(params[:id])
     authorize @bookmark
     if @bookmark.destroy
       flash[:notice] = "The bookmark was deleted successfully."
     else
       flash[:error] = "There was an error deleting the bookmark."
     end
    redirect_to(:back)
   end
     
end