class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  has_many :topics 
  has_many :likes, :dependent => :destroy

   def liked(bookmark) #should this pass in "post" instead of "bookmark?" (that's what the checkpoint says)
     likes.where(bookmark_id: bookmark.id).first # self.likes is implied?
   end
   
end
