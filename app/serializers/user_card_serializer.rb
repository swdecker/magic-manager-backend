class UserCardSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :card_id, :num_owned
  belongs_to :user
  belongs_to :card   
  
end
