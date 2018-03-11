require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }

# Create a comment with an associated user
  let(:comment) { create(:comment) }

# Test that a comment belongs to a user and a post
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

# Test that a comment's body is present and has minimum length of five.  
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: comment.body)
    end
  end

  describe "after_create" do
# Initialize (but don't save) a new comment for post.
    before do
      @another_comment = Comment.new(body: 'Comment Body', post: post, user: user)
    end

# Favorite post, expect FavoriteMailer to receive call to new_comment and trigger the after create callback
    it "sends an email to users who have favorited the post" do
      favorite = user.favorites.create(post: post)
      expect(FavoriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))

      @another_comment.save!
    end

# Test no callback if not favorited.
    it "does not send emails to users who haven't favorited the post" do
      expect(FavoriteMailer).not_to receive(:new_comment)

      @another_comment.save!
    end
  end  
end
