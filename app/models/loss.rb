class Loss < ActiveRecord::Base

  belongs_to :user, dependent: :destroy
  belongs_to :game, dependent: :destroy

end