require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#friend_requests_sent_to?" do
    let(:user) { create(:user) }
    let(:would_be_friend) { create(:user) }
    let!(:user_friend) { create(:user_friend, user: user, friend: would_be_friend) }

    context "when accepted" do 
      before do
        user_friend.update_attribute(:accepted_at, Time.now)
      end

      it "should return false" do 
        expect(user.friend_requests_sent_to?(would_be_friend)).to eq(false)
      end
    end


    context "when not accepted yet" do 
      it "should return true" do 
        expect(user.friend_requests_sent_to?(would_be_friend)).to eq(true)
      end
    end
  end

  describe "#friends_of?" do
    let(:user) { create(:user) }
    let(:would_be_friend) { create(:user) }
    let!(:user_friend) { create(:user_friend, user: user, friend: would_be_friend) }

    context "when accepted" do 
      before do
        user_friend.update_attribute(:accepted_at, Time.now)
      end

      it "should return true" do 
        expect(user.friends_of?(would_be_friend)).to eq(true)
      end
    end

    context "when not accepted" do 
      it "should return false" do 
        expect(user.friends_of?(would_be_friend)).to eq(false)
      end
    end
  end
end
