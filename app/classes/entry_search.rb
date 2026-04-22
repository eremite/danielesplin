class EntrySearch

  include ActiveModel::Model

  attr_accessor :age, :current_user, :ends_on, :user, :on_this_day, :page, :random, :tag, :term, :user_id, :entries

  def load
    self.ends_on = parse_date(ends_on)
    self.user = current_user.users_whose_entries_i_can_edit.find_by(id: user_id) || current_user
    self.user_id ||= user&.id
    if user.born_at.present? && age.present?
      self.ends_on = user.born_at + age.to_i.years
      self.age = nil
    end
    self.entries = find_entries
    self
  end

  private

  def find_entries
    results = Entry.where(user: user).at_desc
    results = results.before(ends_on.end_of_day) if ends_on.present?
    results = results.where(Entry.arel_table[:body].matches("%#{term.to_s.downcase}%")) if term.present?
    results = results.tagged_with(tag, on: :entry_tags) if tag.present?
    results = results.where(id: results.sample.try(:id)) if random.to_i.nonzero?
    results = random_same_day_results if on_this_day
    results.page(page)
  end

  def random_same_day_results
    entry = user.random_entry_on_the_same_day_of_the_year
    Entry.where(id: entry&.id)
  end

  def parse_date(date_string)
    Date.parse(date_string)
  rescue ArgumentError, TypeError
    Date.current
  end

end
