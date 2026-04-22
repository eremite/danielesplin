class NoteSearch

  include ActiveModel::Model

  attr_accessor :current_user, :user_id, :kind, :term, :tag, :random, :page, :notes

  def load
    self.user_id ||= current_user&.id
    self.notes = find_notes
    self
  end

  private

  def find_notes
    results = Note.order(Note.arel_table[:updated_at].desc)
    results =
      if user_id.present?
        results.where(user_id: user_id)
      else
        Current.user.notes
      end
    results = results.where(kind: kind) if kind.present?
    results = results.where(Note.arel_table[:body].matches("%#{term.to_s.downcase}%")) if term.present?
    results = results.tagged_with(tag, on: :note_tags) if tag.present?
    results = results.where(id: results.sample.try(:id)) if random.present?
    results.page(page)
  end

end
