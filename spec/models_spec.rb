require 'spec_helper'

describe "Models" do
  before do
    @matt = User.create(name: "Matt", email: "matt@matt.com", password: "1234")
    @kelvin = User.create(name: "Kelvin", email: "kelvin@kelvin.com", password: "1234")
    @game = Game.create(date: "5/23/16")
    @game2 = Game.create(date: "5/24/16")
  end

  after do
    User.destroy_all
    Game.destroy_all
    GamesUser.destroy_all
    Win.destroy_all
    Loss.destroy_all
    Draw.destroy_all
  end

  it "allows you to create associations between games and users" do
    GamesUser.create(game_id: @game.id, user_id: @matt.id)
    GamesUser.create(game_id: @game.id, user_id: @kelvin.id)
    expect(@matt.games).to include(@game)
    expect(@kelvin.games).to include(@game)
    expect(@game.users.size).to equal(2)
    expect(@game.users).to include(@matt)
    expect(@game.users).to include(@kelvin)
  end

  it "allows you to remove associations and delete games and gamesusers" do
    GamesUser.create(game_id: @game.id, user_id: @matt.id)
    GamesUser.create(game_id: @game.id, user_id: @kelvin.id)
    Game.delete(@game.id)
    GamesUser.delete_all(game_id: @game.id)
    expect(Game.find_by(id: @game.id)).to equal(nil)
    expect(GamesUser.find_by(game_id: @game.id)).to equal(nil)
    expect(@matt.games).not_to include(@game)
    expect(@kelvin.games).not_to include(@game)
  end


  it "allows you to create associations between games and users, with wins and losses" do
    GamesUser.create(game_id: @game.id, user_id: @matt.id)
    GamesUser.create(game_id: @game.id, user_id: @kelvin.id)
    @game.win = Win.create
    @game.loss = Loss.create
    @matt.wins << @game.win
    @kelvin.losses << @game.loss
    expect(@matt.wins).to include(@game.win)
    expect(@kelvin.losses).to include(@game.loss)
  end

  it "allows you to create associations between games and users, with draws" do
    GamesUser.create(game_id: @game.id, user_id: @matt.id)
    GamesUser.create(game_id: @game.id, user_id: @kelvin.id)
    @game.draw = Draw.create
    DrawsUser.create(draw_id: @game.draw.id, user_id: @matt.id)
    DrawsUser.create(draw_id: @game.draw.id, user_id: @kelvin.id)
    expect(@matt.draws).to include(@game.draw)
    expect(@kelvin.draws).to include(@game.draw)
  end

  it "allows you to remove associations and delete games and draws" do
    GamesUser.create(game_id: @game.id, user_id: @matt.id)
    GamesUser.create(game_id: @game.id, user_id: @kelvin.id)
    @game.draw = Draw.create
    DrawsUser.create(draw_id: @game.draw.id, user_id: @matt.id)
    DrawsUser.create(draw_id: @game.draw.id, user_id: @kelvin.id)
    Draw.delete(@game.draw.id)
    DrawsUser.delete_all(draw_id: @game.draw.id)
    expect(Draw.find_by(id: @game.draw.id)).to equal(nil)
    expect(DrawsUser.find_by(draw_id: @game.draw.id)).to equal(nil)
    expect(@matt.draws).not_to include(@game.draw)
    expect(@kelvin.draws).not_to include(@game.draw)
  end
 
end

=begin
game.win.create(user_id: 1)
game.loss.create(user_id: 2)
game.users << matt << kelvin
matt.games << game
kelvin.games << game
matt.wins << game.win
kelvin.losses << game.loss

game2.draw = Draw.create(game_id: 2)
game2.draw.users << matt << kelvin

WIN / LOSS

matt.games.create(date: "5")
=end