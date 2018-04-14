FactoryGirl.define do
  factory :user_friend do
    user_id { FactoryGirl.create(:user).id }
    friend_id { FactoryGirl.create(:user).id }
  end
end
