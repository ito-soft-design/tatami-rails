desc "This task is called by the Heroku scheduler add-on"
task :clean_reports => :environment do
    puts "Clean reports..."
    Report.clean_past_at
    puts "done."
end

desc "This task is called by the Heroku cron add-on"
task :wakeup => :environment do
  require 'net/http'
  uri = URI.parse('http://tatami.herokuapp.com/')
  Net::HTTP.get(uri)
  uri = URI.parse('http://tatami-ex.herokuapp.com/')
  Net::HTTP.get(uri)
end
