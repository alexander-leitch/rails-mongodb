class WechatsController < ApplicationController
  wechat_responder

  # 默认文字信息responder
  on :text do |request, content|
    Message.create({:openid => request[:touser].to_s, :raw_xml => request.to_json, :content => content, :event => 'wechat'}).save
    request.reply.text "echo: #{content}" #Just echo
  end

  # 当请求的文字信息内容为'help'时, 使用这个responder处理
  on :text, with:"help" do |request, help|
    request.reply.text "help content" #回复帮助信息
  end

  # 当请求的文字信息内容为'<n>条新闻'时, 使用这个responder处理, 并将n作为第二个参数
  on :text, with:"rmc" do |request, count|
    articles_range = (0...10)
    request.reply.news(articles_range) do |article, i| #回复"articles"
      article.item title: "标题#{i}", description:"内容描述#{i}", pic_url: "http://www.baidu.com/img/bdlogo.gif", url:"http://www.baidu.com/"
    end
  end

  # 当收到 EventKey 为 mykey 的事件时
  on :event, with: "mykey" do |request, key|
    request.reply.text "收到来自#{request[:FromUserName]} 的EventKey 为 #{key} 的事件"
  end

  # 处理图片信息
  on :image do |request|
    request.reply.image(request[:MediaId]) #直接将图片返回给用户
  end

  # 处理语音信息
  on :voice do |request|
    request.reply.voice(request[:MediaId]) #直接语音音返回给用户
  end

  # 处理视频信息
  on :video do |request|
    nickname = wechat.user(request[:FromUserName])["nickname"] #调用 api 获得发送者的nickname
    request.reply.video(request[:MediaId], title: "回声", description: "#{nickname}发来的视频请求") #直接视频返回给用户
  end

  # 处理地理位置信息
  on :location do |request|
    request.reply.text("#{request[:Location_X]}, #{request[:Location_Y]}") #回复地理位置
  end

  # 当用户加关注
  on :event, with: 'subscribe' do |request, key|
    request.reply.text "#{request[:FromUserName]} #{key} now"
  end

  # 当用户取消关注订阅
  on :event, with: 'unsubscribe' do |request, key|
    request.reply.text "#{request[:FromUserName]}无法收到这条消息。"
  end

  # 当无任何responder处理用户信息时,使用这个responder处理
  on :fallback, respond: "fallback message"  
end