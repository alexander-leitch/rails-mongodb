class User
  include Mongoid::Document
  include Mongoid::Paperclip
  
  embeds_many :pictures, :cascade_callbacks => true
  accepts_nested_attributes_for :pictures
  
  # Include default devise modules. Others available are:
  # :recoverable, :rememberable, :validatable, :confirmable, :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :timeoutable, :lockable, :omniauthable, :omniauth_providers => [:digitalocean, :twitter]
  
  #has_mongoid_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  #validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  # Validates via connecting to smtp server
  #validates_email_realness_of :email # Doesn't Work :(
  
  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  field :locked_at,       type: Time
  
  field :provider,  type: String
  field :uid,       type: String
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
