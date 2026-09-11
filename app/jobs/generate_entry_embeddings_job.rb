class GenerateEntryEmbeddingsJob < ApplicationJob

  queue_as :default

  def perform
    entries.find_in_batches(batch_size: 20) do |entries|
      embedding_result = RubyLLM.embed(entries.map(&:body), model: 'gemini-embedding-2', dimensions: 768)
      entries.each_with_index do |entry, index|
        entry.update_columns(embedding: embedding_result.vectors[index])
      end
    rescue RubyLLM::Error => e
      Rails.logger.error("GenerateEntryEmbeddingsJob: Batch embedding failed: #{e.message}")
    end
  end

  private

  def entries
    Entry.tagged_with('ai').where.not(body: [nil, '']).where(embedding: nil)
  end

end
