desc "This task is called by the Heroku scheduler add-on"
task :clean_reports => :environment do
    puts "Clean reports..."
    Report.clean_past_at
    puts "done."
end

desc "This task is called by the Heroku scheduler add-on"
task :clean_reports => :environment do
    puts "Clean reports..."
    Report.clean_past_at
    puts "done."
end
