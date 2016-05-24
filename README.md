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












