require 'rake'

namespace :tests do
  desc 'Import News'
  task :check => :environment do |task, args|
    puts "Testing Email Thing"
    
    EmailValidator.check('alex@openstyle.co.za')
    
  end

end