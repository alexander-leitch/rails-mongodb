require 'rake'
require 'telegrammer'

namespace :telegram do
  task :set => :environment do |task, args|
    bot = Telegrammer::Bot.new("110515929:AAGg8C3vXhSimWGZB8OzF0E0la8Seff6bB4")
    response = bot.set_webhook("https://agile-oasis-2482.herokuapp.com/telegram")
    puts response.inspect
  end
  task :clear => :environment do |task, args|
    bot = Telegrammer::Bot.new("110515929:AAGg8C3vXhSimWGZB8OzF0E0la8Seff6bB4")
    response = bot.set_webhook("")
    puts response.inspect
  end
  task :updater => :environment do |task, args|
    bot = Telegrammer::Bot.new("110515929:AAGg8C3vXhSimWGZB8OzF0E0la8Seff6bB4")
    begin
      bot.set_webhook("")
      bot.get_updates do |message|
        puts "In chat #{message.chat.id}, @#{message.from.username} said: #{message.text}"
        #puts message.inspect
        Message.create({:openid => message.from.id, :raw_xml => message.to_json, :content => message.text, :event => 'telegram'}).save
        bot.send_message(chat_id: message.chat.id, text: "You said: #{message.text}")
        # Here you can also process message text to detect user commands
        # To learn more about commands, see https://core.telegram.org/bots#commands
      end
    ensure
      puts "Clearing Webhook"
      bot.set_webhook("")
    end
  end
end
