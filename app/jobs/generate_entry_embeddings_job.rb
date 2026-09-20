class GenerateEntryEmbeddingsJob < ApplicationJob

  queue_as :default

  def perform
    entries.find_in_batches(batch_size: 20) do |entries|
      vectors = AI.embed(entries.map(&:body))
      entries.each_with_index do |entry, index|
        entry.update_columns(embedding: vectors[index])
      end
    end
  end

  private

  def entries
    Entry.tagged_with('ai').where.not(body: [nil, '']).where(embedding: nil)
  end

end
