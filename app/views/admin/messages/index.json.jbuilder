json.array!(@messages) do |message|
  json.extract! message, :id, :openid, :event, :content, :raw_xml
  json.url message_url(message, format: :json)
end
