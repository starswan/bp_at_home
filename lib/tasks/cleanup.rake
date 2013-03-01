desc "This is a task to add on auth tokens to old users who came from the days of sessions"
task :add_auth_tokens => :environment do
  puts "Adding auth tokens..."
  Doctor.all.each do |doc|
    doc.generate_token(:auth_token)
    doc.save!
  end
  puts "done."
end