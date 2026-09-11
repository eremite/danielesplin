require 'test_helper'

class GenerateEntryEmbeddingsJobTest < ActiveJob::TestCase

  test 'perform' do
    entry = entries(:base).tap { |e| e.update!(embedding: nil, body: 'Body', entry_tag_list: 'ai') }
    embedding_result = Data.define(:vectors).new(vectors: [[1]])
    RubyLLM.stub :embed, embedding_result do
      GenerateEntryEmbeddingsJob.perform_now
    end
    assert_equal [1], entry.reload.embedding
  end

  test 'perform with error ' do
    entry = entries(:base).tap { |e| e.update!(embedding: nil, body: 'Body', entry_tag_list: 'ai') }
    RubyLLM.stub :embed, ->(*_args) { raise RubyLLM::Error, 'Batch embedding failed' } do
      GenerateEntryEmbeddingsJob.perform_now
    end
    assert_nil entry.reload.embedding
  end

end
