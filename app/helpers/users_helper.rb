module UsersHelper
  def user_has_posts_or_comments
    current_user.posts.any? || current_user.comments.any?
  end 
end
