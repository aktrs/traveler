class MessagesController < ApplicationController
    before_action :authenticate_user!, :only => [:create]

    def index
        @messages = @conversation.messages
        @message = @conversation.messages.new
    end

    def create
        @message = @conversation.messages.new(message_params)
        @message.user = current_user

        if @message.save
            redirect_to conversation_messages_path(@conversation)
        else
            flash[:alert] = "Unable to send message."
            render :index
        end

        if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
            @message = Message.create(params.require(:message).permit(:message, :user_id, :content, :room_id).merge(:user_id => current_user.id))
            redirect_to "/rooms/#{@message.room_id}"
        else
            redirect_back(fallback_location: root_path)
        end
    end
    end

    private

    def set_conversation
        @conversation = Conversation.find(params[:conversation_id])
    end

    def message_params
        params.require(:message).permit(:body)
    end
end
