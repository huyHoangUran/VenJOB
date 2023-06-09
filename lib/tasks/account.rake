namespace :account do
  desc 'Delete unconfirmed accounts older than 24 hours'
  task cleanup_unconfirmed: :environment do
    User.where(confirmed_at: nil).where('created_at <= ?', 24.hours.ago).destroy_all
  end

end
