class Game < ActiveRecord::Base

  has_and_belongs_to_many :users
  has_one :draw
  has_one :win
  has_one :loss
  
end