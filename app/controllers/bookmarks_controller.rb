class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def new
    @bookmark = Bookmark.new
    @topic = Topic.find(params[:topic_id])
    # need in new as well?
    # authorize @bookmark
  end
  
  def create
    @bookmark = Bookmark.new(params.require(:bookmark).permit(:url))
    @topic = Topic.find(params[:topic_id])
    authorize @bookmark
    @bookmark.topic = @topic
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
       # need this?
       # authorize @bookmark
     end
  
   def update
       @bookmark = Bookmark.find(params[:id])
        authorize @bookmark
       if @bookmark.update_attributes(params.require(:bookmark).permit(:url))
         flash[:notice] = "Bookmark was updated."
         redirect_to [@topic, @bookmark]
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