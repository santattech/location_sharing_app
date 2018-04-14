class UserFriend < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates_presence_of :user, :friend

  scope :accepted, -> { where.not(accepted_at: nil) }
  scope :not_accepted, -> { where(accepted_at: nil) }
end
