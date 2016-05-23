class GamesController < ApplicationController
  configure do
    set :views, "app/views"
  end

  get '/users/:slug/games' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id = @user.id
      erb :'/users/games/index'
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
    @game = Game.create(date: params[:date])
    if params[:draw]
      @draw = Draw.create(game_id: @game.id)
      @game.draw = @draw
      @draw.users << @user
      @draw.users << User.find_by(id: params[:players][:id]) 
      @game.users << @user
      @game.users << User.find_by(id: params[:players][:id]) 
      @game.save
      redirect "/users/#{@user.slug}/games/#{@game.id}"
    else
      winner = User.find_by(id: params[:winner][:id])
      loser = User.find_by(id: params[:loser][:id])
      @win = Win.create(game_id: @game.id, user_id: winner.id )
      @loss = Loss.create(game_id: @game.id, user_id: loser.id )
      @game.users << winner
      @game.users << loser
      @game.save
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

  get '/users/:slug/games/:id/edit' do

  end

  patch '/users/:slug/games/:id' do
    #edit game
  end

  delete '/users/games/:id/delete' do
    #delete game
  end

end