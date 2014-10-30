class Notifier < ActionMailer::Base

  default from: Rails.application.secrets.emails['from'].to_s

  def comment_notification(comment)
    @comment = comment
    mail({
      to: User.where(:role => %w(father mother)).pluck(:email),
      subject: "New comment! #{comment.user.try(:name)} on #{comment.post.try(:title)}",
    })
  end

  def nutritional_contact_notification(name, from_email, body)
    @name = name
    @from_email = from_email
    @body = body
    params = {
      to: User.where(:role => %w(father mother)).pluck(:email),
      subject: 'Question for a Dietitian',
    }
    if Rails.application.config.email_regex.match(@from_email)
      params[:reply_to] = @from_email
    end
    mail(params)
  end

end
