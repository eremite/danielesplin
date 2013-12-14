class Notifier < ActionMailer::Base

  default from: Figaro.env.email_username.to_s

  def comment_notification(comment)
    @comment = comment
    mail({
      to: User.where(:role => %w(father mother)).pluck(:email),
      subject: "New comment! #{comment.user.try(:name)} on #{comment.entry.try(:title)}",
    })
  end

end
