require 'rails_helper'

RSpec.describe UserFriend, type: :model do
  context "scopes" do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }
    let(:friend1) {create(:user) }
    let!(:user_friend)  { create(:user_friend, user: user, friend_id: friend.id, accepted_at: Time.now) }
    let!(:not_accepted_user_friend)  { create(:user_friend, user: user, friend_id: friend1.id, accepted_at: nil) }

    describe ".accepted" do 
      it "should return accepted user friends" do
        expect(UserFriend.accepted).to include(user_friend)
        expect(UserFriend.accepted).to_not include(not_accepted_user_friend)
      end
    end

    describe ".not_accepted" do
      it "should return not accepted user friends" do
        expect(UserFriend.not_accepted).to_not include(user_friend)
        expect(UserFriend.not_accepted).to include(not_accepted_user_friend)
      end
    end
  end
end