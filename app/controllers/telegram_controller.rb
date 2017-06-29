class TelegramsController < ApplicationController
  # You have to disable authenticity token verification for the action that handles the bot updates
  # skip_before_action :verify_authenticity_token, only: [:create, :show]
  
  def create
    token = ENV["TELEGRAM_TOKEN"]
    
    update = Telegrammer::DataTypes::Update.new(
      update_id: params[:update_id],
      message: params[:message]
    )
    
    puts update
    
  end
end