class CreateDraws < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.belongs_to :game
    end
  end
end
