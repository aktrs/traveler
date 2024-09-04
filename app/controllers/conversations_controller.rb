class ConversationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
    end

    def create
        @conversation = Conversation.between(params[:sender_id], params[:receiver_id])
    
        if @conversation.persisted?
            redirect_to conversation_messages_path(@conversation)
        else
            flash[:alert] = "Unable to create conversation."
            redirect_to conversation_path
        end
    end
end
