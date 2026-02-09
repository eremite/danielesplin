require 'test_helper'

class PostAccessGrantTest < ActiveSupport::TestCase

  test 'load!' do
    user = users(:base).tap { |u| u.update_columns(access_token: nil, access_token_expires_at: nil) }
    post = posts(:base)
    grant = PostAccessGrant.new(user_id: user.id, post_id: post.id).load!
    assert_equal user.id, grant.user.id
    assert_equal post.id, grant.post.id
    assert_not_nil user.reload.access_token
    assert_not_nil user.access_token_expires_at
  end

  test 'mailto' do
    user = users(:base)
    user.update_columns(email: 'uninformed@example.com', access_token: 't0k3n', access_token_expires_at: 1.week.from_now)
    post = posts(:base).tap { |p| p.update_columns(body: '<h1>New News</h1>') }
    grant = PostAccessGrant.new(user: user, post: post)
    assert_includes grant.mailto, 'uninformed@example.com'
    assert_includes grant.mailto, post.id.to_s
    assert_includes grant.mailto, 'News'
    assert_includes grant.mailto, 't0k3n'
  end

end
