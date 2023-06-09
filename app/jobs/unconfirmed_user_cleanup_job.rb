class UnconfirmedUserCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    users_to_delete = User.where('confirmed_at < ?', 24.hours.ago)
    users_to_delete.destroy_all
  end
end
