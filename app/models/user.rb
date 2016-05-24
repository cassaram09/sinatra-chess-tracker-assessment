class User < ActiveRecord::Base

  has_secure_password

  has_many :games_users
  has_many :games, through: :games_users, dependent: :destroy

  has_many :draws_users
  has_many :draws, through: :draws_users, dependent: :destroy
  
  has_many :wins
  has_many :losses

  def slug
    slug = self.name.strip.downcase.gsub(/[\&\$\+\,\/\:\;\=\?\@\#\s\<\>\[\]\{\}\|\~\^|\%\(\)\*]/, "-").gsub(/\-{2,}/, "-")
  end

  def self.find_by_slug(slug)
    self.all.each do |object|
      name = object.slug
      if name == slug
        return object
      end
    end
  end
  
end