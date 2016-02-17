class MessagesController < ApplicationController
  before_action :set_message, only: [:show]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.paginate(:page => params[:page], :per_page => 10)
    set_meta_tags title: 'Incoming WeChat Messages'
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:openid, :event, :content, :raw_xml)
    end
end
