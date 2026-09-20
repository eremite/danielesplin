require 'test_helper'

class GenerateEntryEmbeddingsJobTest < ActiveJob::TestCase

  test 'perform' do
    entry = entries(:base).tap { |e| e.update!(embedding: nil, body: 'Body', entry_tag_list: 'ai') }
    AI.stub :embed, [[1]] do
      GenerateEntryEmbeddingsJob.perform_now
    end
    assert_equal [1], entry.reload.embedding
  end

end
