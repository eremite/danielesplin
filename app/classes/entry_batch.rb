class EntryBatch

  include ActiveModel::Model

  attr_accessor :entry_params_by_user_id

  def load
    self.entry_params_by_user_id = {}
    children.each { |user| entry_params_by_user_id[user.id] = entry_params_for_user(user) }
    self
  end

  def opened_by
    @opened_by ||= User.find_by(id: Rails.cache.read("entry_batch_opened_by_user_id"))
  end

  def autosave_interval
    opened_by.present? ? 0 : 5000
  end

  def save
    Rails.cache.write("entry_batch_opened_by_user_id", Current.user&.id, expires_in: 15.seconds)
    entry_params_by_user_id.each do |user_id, entry_params|
      user = User.find(user_id)
      entry = user.entries.find_by(id: entry_params[:id])
      entry ||= existing_entry_for_user(user)
      entry ||= user.entries.new(at: Time.current)
      entry.update(entry_params.slice(:body)) if entry_params[:body].present?
    end
    true
  end

  private

  def children
    User.where(role: :baby).order(born_at: :asc)
  end

  def entry_params_for_user(user)
    entry = existing_entry_for_user(user)
    {
      body: entry&.body,
      id: entry&.id,
      user: user,
    }
  end

  def existing_entry_for_user(user)
    user.entries.find_by(at: Time.current.all_day)
  end

end
