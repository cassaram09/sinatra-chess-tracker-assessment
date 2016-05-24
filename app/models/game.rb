class Game < ActiveRecord::Base

  has_many :games_users, dependent: :delete_all
  has_many :users, through: :games_users

  has_one :draw
  has_one :win
  has_one :loss
  
end