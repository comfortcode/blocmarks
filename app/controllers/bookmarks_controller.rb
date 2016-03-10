class BookmarksController < ApplicationController
  def show
  end

  def new
    @bookmark = Bookmark.new
  end
  
  def create
    @bookmark = Bookmark.new(params.require(:bookmark).permit(:url))
    @topic = params(:topic)
    @bookmark.topic = @topic
    if @bookmark.save
      flash[:notice] = "Bookmark was saved"
      redirect_to [@topic, @bookmark]
    else 
      flash[:error] = "There was an error saving the bookmark. Please try again"
      render :new
    end 
  end 

  def edit
  end
end
