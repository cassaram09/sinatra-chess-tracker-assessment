class GamesUser < ActiveRecord::Base

  belongs_to :game, dependent: :delete
  belongs_to :user, dependent: :delete

end