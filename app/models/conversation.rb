class Conversation < ApplicationRecord
    belongs_to :sender, class_name, 'User', foreign_key: :sender_id
    belongs_to :receiver, class_name,'User', foreign_key: :receiver_id
    has_many :messages, dependent: :destroy
    has_many :entries, dependent: :destroy

    validates :sender_id, uniquness: { scope: :receiver_id }

    def self.between(sender_id, receiver_id)
        where(sender_id: sender_id, receiver_id: receiver_id).or(
            where(sender_id: receiver_id, receiver_id: sender_id)
        ).first_or_create(sender_id: sender_id, receiver_id: receiver_id)
    end
end
