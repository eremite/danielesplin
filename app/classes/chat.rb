class Chat

  include ActiveModel::Model

  attr_accessor :query, :content

  def ask!
    self.content = AI.ask(prompt) if query.present?
  end

  private

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
    query_vector = AI.embed(query)
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
