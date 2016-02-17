class Message
  include Mongoid::Document
  field :openid, type: String
  field :event, type: String
  field :content, type: String
  field :raw_xml, type: String
end
