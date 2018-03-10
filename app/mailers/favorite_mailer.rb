class FavoriteMailer < ApplicationMailer
  default from: "gayden_napper@msn.com"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(post)
    headers["Message-ID"] = "<posts/#{post.id}@sheltered-beyond-32791.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@sheltered-beyond-32791.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@sheltered-beyond-32791.herokuapp.com>"

    @post = post
   
    mail(to: post.user.email, subject: "You're following your post: #{post.title}")
  end 
end


