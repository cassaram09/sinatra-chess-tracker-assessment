class GamesController < ApplicationController

  
  get '/users/:slug/games' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      erb :'/users/index'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  get '/users/:slug/games/new' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      erb :'/users/games/new'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  post '/users/:slug/games' do
    binding.pry
    @user = Helpers.current_user(session)
    if params[:draw]
      #if !params[:players]
      #  flash[:message] = "Please try again." 
      #  redirect "/users/#{@user.slug}/games/new"
     # end
      @game = Game.create(date: params[:date]) #create the game
      @game.draw = Draw.create(game_id: @game.id) #create draw and add to the game
      GamesUser.create(game_id: @game.id, user_id: @user.id)
      GamesUser.create(game_id: @game.id, user_id: User.find_by(id: params[:players][:id]).id)
      DrawsUser.create(draw_id: @game.draw.id, user_id: @user.id)
      DrawsUser.create(draw_id: @game.draw.id, user_id: User.find_by(id: params[:players][:id]).id)
      redirect "/users/#{@user.slug}/games/#{@game.id}"
    else
      #if params[:winner] == nil || params[:loser] == nil
      #  flash[:message] = "Please try again!" 
      #  redirect "/users/#{@user.slug}/games/new"
      #end
      winner = User.find_by(id: params[:winner][:id]) #find the winner
      loser = User.find_by(id: params[:loser][:id]) #find the loser
      #if @user != winner && @user != loser || loser == winner
      #  flash[:message] = "Please try again@" 
      #  redirect "/users/#{@user.slug}/games/new"
      #end
      @game = Game.create(date: params[:date]) #create a new game
      @game.win = Win.create(game_id: @game.id) #create the win and associate it to the game
      @game.loss = Loss.create(game_id: @game.id) #create the loss and associate to the game
      @game.users << winner << loser #create association between playerss and game
      winner.wins << @game.win #add win to winner
      loser.losses << @game.loss #add loss to loser
    redirect "/users/#{@user.slug}"
    end
  end

  get '/users/:slug/games/:id' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id = @user.id
      @game = Game.find_by(id: params[:id])
      erb :'/users/games/show'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  get '/users/:slug/games/:id/edit' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id = @user.id
      @game = Game.find_by(id: params[:id])
      erb :'/users/games/edit'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  patch '/users/:slug/games/:id' do
    binding.pry
    @user = Helpers.current_user(session)
    @game = Game.find_by(id: params[:id])
    @game.update(date: params[:date])
    if params[:draw]
      @player2 = User.find_by(id: params[:players][:id])
      #if !params[:players]
      #  flash[:message] = "Please try again." 
      #  redirect "/users/#{@user.slug}/games/new"
      #end
      #if draw does not yet exist
      if @game.draw == nil
        Win.delete(@game.win.id)
        Loss.delete(@game.loss.id)
        @game.draw = Draw.create(game_id: @game.id)
        @game.draw.users << @user << @player2
        @game.users << @user << @player2
        redirect "/users/#{@user.slug}/games/#{@game.id}"
      else #if we're changing the player
        @game.draw.users.clear
        @game.users.clear 
        @game.draw.users << @user << @player2
        @game.users << @user<< @player2
        @game.save
        @game.draw.save
        redirect "/users/#{@user.slug}/games/#{@game.id}"
      end
    else
      if params[:winner] == nil || params[:loser] == nil
        flash[:message] = "Please try again!" 
        redirect "/users/#{@user.slug}/games/new"
      end
      winner = User.find_by(id: params[:winner][:id])
      loser = User.find_by(id: params[:loser][:id])
      if @user != winner && @user != loser || loser == winner
        flash[:message] = "Please try again@" 
        redirect "/users/#{@user.slug}/games/new"
      end
      #problem area
      @game.users.clear
      @game.user_ids.clear
      @win = Win.find_or_create_by(game_id: @game.id, user_id: winner.id )
      @loss = Loss.find_or_create_by(game_id: @game.id, user_id: loser.id )
      binding.pry
      @game.users << winner
      @game.users << loser
      @game.win.user = winner
      @game.loss.user = loser
      @game.save
    redirect "/users/#{@user.slug}"
    end
  end

  delete '/users/games/:id/delete' do
    #delete game
  end

end