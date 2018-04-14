class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations, dependent: :destroy

  has_many :user_friends, dependent: :destroy
  has_many :friends, through: :user_friends, source: :friend

  #user whoreceives frnd request
  has_many :friend_requests, -> {where(accepted_at: nil) }, class_name: 'UserFriend', foreign_key: :friend_id
  has_many :friend_requests_sender, through: :friend_requests, source: :user

  has_many :shared_locations, dependent: :destroy

  has_many :shared_locations_by, class_name: 'SharedLocation', foreign_key: :share_with_id
  has_many :locations_shared_with_me, through: :shared_locations_by, source: :location  

  def image_url
    "/assets/user.png"
  end

  def friend_requests_sent_to?(u)
    user_friends.not_accepted.where(friend_id: u.id).exists?
  end

  def friends_of?(u)
    user_friends.where(friend_id: u.id).accepted.exists?
  end

end
