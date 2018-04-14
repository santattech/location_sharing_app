class SharedLocation < ActiveRecord::Base
  validates_presence_of :user, :location , :share_with_id

  belongs_to :user
  belongs_to :share_with, class_name: 'User'
  belongs_to :location
end
