class PostAccessGrant

  include ActiveModel::Model

  attr_accessor :user_id, :user, :post_id, :post, :url

  def load!
    self.user = User.find(user_id)
    user.grant_access!
    self.post = Post.find(post_id)
    self
  end

  def mailto
    "mailto:#{user.email}?#{query}"
  end

  private

  def query
    {
      subject: "New Update: #{post.title}",
      body: <<~SUBJECT
        This link will work for #{User::ACCESS_TOKEN_EXPIRES_IN.inspect}:

        #{url}/posts/#{post.id}?access_token=#{user.access_token}

        Let me know if you have any questions or comments or want to stop getting updates.
      SUBJECT
    }.to_query
  end

end
