class Chat

  include ActiveModel::Model

  attr_accessor :query, :content

  def ask!
    self.content = ask if query.present?
  end

  private

  def ask
    chat_model.ask(prompt).content
  rescue RubyLLM::Error => e
    Rails.logger.error("Chat: #{e.message}")
  end

  def chat_model
    RubyLLM.chat(model: 'gemini-3.6-flash')
  end

  def prompt
    <<~PROMPT
      Answer the user's question. Format responses in html.
      Today's date is #{Time.zone.today}.
      <CONTEXT>
      #{relevant_entries.map { |e| "#{e.at}\n#{e.body}" }.join("\n---\n")}
      </CONTEXT>

      User Question: #{query}
    PROMPT
  end

  def relevant_entries
    query_vector = RubyLLM.embed(query, model: 'gemini-embedding-2', dimensions: 768).vectors
    entries_with_similarity = Entry.where.not(embedding: nil).map do |entry|
      similarity = cosine_similarity(query_vector, entry.embedding)
      [entry, similarity]
    end
    entries_with_similarity.sort_by { |_, sim| -sim }.first(5).map(&:first)
  end

  def cosine_similarity(vec_a, vec_b)
    vec_a.zip(vec_b).sum { |a, b| a * b }
  end

end
