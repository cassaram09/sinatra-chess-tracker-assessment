class Draw < ActiveRecord::Base

  has_many :draws_users
  has_many :users, through: :draws_users, dependent: :destroy
  
  belongs_to :game, dependent: :destroy

end