class CreateDrawsUsers < ActiveRecord::Migration
  def change
    create_table :draws_users do |t|
      t.belongs_to :draw
      t.belongs_to :user
    end
  end
end
