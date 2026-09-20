module AI
  def self.embed(text)
    RubyLLM.embed(text, model: 'gemini-embedding-2', dimensions: 768).vectors
  end

  def self.ask(prompt)
    RubyLLM.chat(model: 'gemini-3.6-flash').ask(prompt).content
  end
end
