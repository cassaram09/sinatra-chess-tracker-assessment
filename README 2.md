# sinatra-chess-tracker
Chess Game Tracker

User
 - name
 - email
 - password_digest
 - has many wins, through games
 - has many wins, through games
 - has many wins, through games
 - has many games

user.games
user.wins 
user.losses 
user.draws

Game object  
 - date 
 - has many users
 - has_one win
 - has_one draw
 - has_one loss
game.users 
game.win 
game.loss 
game.draw  


Win
 belongs_to Game
 belongs_to User

Loss
  belongs_to Game

Draw
  belongs_to Game

matt = User.create(name: "Matt", email: "matt@matt.com", password: "1234")
kelvin = User.create(name: "Kelvin", email: "kelvin@kelvin.com", password: "1234")
game = Game.create(date: "5/23/16")
game2 = Game.create(date: "5/24/16")

outcome1 = Outcome.create(name: "draw")
outcome2 = Outcome.create(name: "win")

win = Win.create(user_id: 1, game_id: 1)
<<<<<<< HEAD
loss = Loss.create(user_id: 2, game_id: 1)
draw = Draw.create(game_id: 2)
=======
loss = Loss.create(user_id: 2, game_id: 2)
>>>>>>> parent of 440d7a8... changed model and migrations so draws can belong to more than one user
