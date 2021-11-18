class Notifier < ActionMailer::Base

  default from: ENV["FROM_EMAIL"]

  def comment_notification(comment)
    @comment = comment
    mail({
      to: User.where(:role => %w(father mother)).pluck(:email),
      subject: "New comment! #{comment.user.try(:name)} on #{comment.post.try(:title)}",
    })
  end

end
