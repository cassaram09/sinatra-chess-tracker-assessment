class CreateLosses < ActiveRecord::Migration
  def change
    create_table :losses do |t|
      t.belongs_to :game
      t.belongs_to :user
    end
  end
end
