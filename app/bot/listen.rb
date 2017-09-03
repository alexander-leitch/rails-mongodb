# app/bot/listen.rb

require "facebook/messenger"

include Facebook::Messenger

# Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])


# Bot.on :message do |message|
  # message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
  # message.sender      # => { 'id' => '1008372609250235' }
  # message.sent_at     # => 2016-04-22 21:30:36 +0200
  # message.text        # => 'Hello, bot!'
  
  # message.mark_seen
  # message.reply(text: 'Hello, human!')
  # Bot.deliver({recipient: message.sender,message: {text: message.text}}, access_token: ENV["ACCESS_TOKEN"])
  # Bot.deliver({
  #   recipient: message.sender,
  #   message: {
  #     text: message.text
  #   }
  # }, access_token: ENV["ACCESS_TOKEN"])
# end

Bot.on :message do |message|
  message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
  message.sender      # => { 'id' => '1008372609250235' }
  message.seq         # => 73
  message.sent_at     # => 2016-04-22 21:30:36 +0200
  message.text        # => 'Hello, bot!'
  message.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]
  
  message.mark_seen
  message.typing_on
  
  puts message.inspect
  Message.create({
    :openid => message.sender['id'].to_s, 
    :raw_xml => message.to_json, 
    :content => message.text, 
    :event => 'messenger'
  }).save
  message.reply(text: 'Hello, human!')
  message.typing_off
  
  # message.reply(text: 'Hello, human!')
  # message.reply(
  #   attachment: {
  #     type: 'template',
  #     payload: {
  #       template_type: 'button',
  #       text: 'Human, do you like me?',
  #       buttons: [
  #         { type: 'postback', title: 'Yes', payload: 'HARMLESS' },
  #         { type: 'postback', title: 'No', payload: 'EXTERMINATE' }
  #       ]
  #     }
  #   }
  # )
  
  # message.reply(
  #   text: 'Human, who is your favorite bot?',
  #   quick_replies: [
  #     {
  #       content_type: 'postback',
  #       title: 'You are!',
  #       payload: 'HARMLESS'
  #     }
  #   ]
  # )
  
  # message.reply(
  #   attachment: {
  #     type: 'image',
  #     payload: {
  #       url: 'http://sky.net/visual-aids-for-stupid-organisms/pig.jpg'
  #     }
  #   }
  # )
end

Bot.on :postback do |postback|
  postback.sender    # => { 'id' => '1008372609250235' }
  postback.recipient # => { 'id' => '2015573629214912' }
  postback.sent_at   # => 2016-04-22 21:30:36 +0200
  postback.payload   # => 'EXTERMINATE'

  if postback.payload == 'EXTERMINATE'
    puts "Human #{postback.recipient} marked for extermination"
    Bot.deliver({recipient: postback.sender,message: {text: "Human #{postback.recipient} marked for extermination"}}, access_token: ENV["ACCESS_TOKEN"])
  end
  if postback.payload == 'HARMLESS'
    Bot.deliver({recipient: postback.sender,message: {text: "Human #{postback.recipient} marked as Harmless"}}, access_token: ENV["ACCESS_TOKEN"])
  end
end

Bot.on :message_echo do |message_echo|
  message_echo.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
  message_echo.sender      # => { 'id' => '1008372609250235' }
  message_echo.seq         # => 73
  message_echo.sent_at     # => 2016-04-22 21:30:36 +0200
  message_echo.text        # => 'Hello, bot!'
  message_echo.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]
  puts message_echo.inspect
  # Log or store in your storage method of choice (skynet, obviously)
end

Bot.on :optin do |optin|
  optin.sender    # => { 'id' => '1008372609250235' }
  optin.recipient # => { 'id' => '2015573629214912' }
  optin.sent_at   # => 2016-04-22 21:30:36 +0200
  optin.ref       # => 'CONTACT_SKYNET'
  puts optin.inspect
  optin.reply(text: 'Ah, human!')
end

Bot.on :delivery do |delivery|
  delivery.ids       # => 'mid.1457764197618:41d102a3e1ae206a38'
  delivery.sender    # => { 'id' => '1008372609250235' }
  delivery.recipient # => { 'id' => '2015573629214912' }
  delivery.at        # => 2016-04-22 21:30:36 +0200
  delivery.seq       # => 37
  puts delivery.inspect
  puts "Human was online at #{delivery.at}"
end

Bot.on :referral do |referral|
  referral.sender    # => { 'id' => '1008372609250235' }
  referral.recipient # => { 'id' => '2015573629214912' }
  referral.sent_at   # => 2016-04-22 21:30:36 +0200
  referral.ref       # => 'MYPARAM'
  puts referral.inspect
end