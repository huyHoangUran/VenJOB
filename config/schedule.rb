every 1.day, at: '4:00 am' do
  rake 'account:cleanup_unconfirmed'
end