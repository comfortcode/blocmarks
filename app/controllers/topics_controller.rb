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
    @topic = Topic.find(params[:id])
    authorize @topic
   end

def self.find_or_create_by_topic(*args)
  options = args.extract_options!
  options[:name] = args[0] if args[0].is_a?(String)
  case_sensitive = options.delete(:case_sensitive)
  conditions = case_sensitive ? ['name = ?', options[:name]] : 
                                ['UPPER(name) = ?', options[:name].upcase] 
  first(:conditions => conditions) || create(options)
end

end