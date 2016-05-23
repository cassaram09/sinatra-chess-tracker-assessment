class CreateWins < ActiveRecord::Migration
  def change
    create_table :wins do |t|
      t.belongs_to :game
      t.belongs_to :user
    end
  end
end
