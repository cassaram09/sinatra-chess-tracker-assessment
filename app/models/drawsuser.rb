class DrawsUser < ActiveRecord::Base

  belongs_to :draw, dependent: :destroy
  belongs_to :user, dependent: :destroy

end