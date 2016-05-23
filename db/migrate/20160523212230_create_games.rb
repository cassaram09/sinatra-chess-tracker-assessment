class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :date
      t.timestamp null: false
    end
  end
end
