class TopicsController < ApplicationController
  def index
    authorize Topic
    @topics = current_user.topics
    @new_topic = Topic.new
    @like = Like.new
  end 
  
  def create
    @topic = current_user.topics.new(params.require(:topic).permit(:title))
    authorize @topic
     if @topic.save
       flash[:notice] = "Your new topic was saved!"
     else
       flash[:error] = "There was an error saving the topic. Please try again!"
     end
     redirect_to topics_path
  end

 def destroy
     @topic = Topic.find(params[:id])
     authorize @topic
     @topic.destroy
     redirect_to topics_path
 end

  def show
    if params.has_key?(:id)
      @topic = Topic.find(params[:id])
    else
       @topic = Topic.find_by(title: (params[:title]))
    end 
    authorize @topic
   end

end