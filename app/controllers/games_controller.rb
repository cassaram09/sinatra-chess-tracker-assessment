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
      @draw = Outcome.create(name: "draw", game_id: @game.id)
      @game.users << @user
      @game.users << User.find_by(id: params[:players][0][:id]) 
      @draw.save
      redirect "/users/#{@user.slug}/games/#{@game.id}"
    else
      @draw = Outcome.create(name: "draw", game_id: @game.id)
    redirect "/users/#{@users.slug}"
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