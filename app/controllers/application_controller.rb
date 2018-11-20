
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts' do
  	@posts = Post.all

  	erb :index
  end

  get '/posts/new' do
  	erb :new
  end

  get '/posts/:id' do
  	@post = Post.find(params[:id])

  	erb :show
  end

  get '/posts/:id/edit' do
  	@post = Post.find(params[:id])
  	erb :edit
  end

  post '/posts' do
  	Post.create(params)
  	@posts = Post.all

  	# binding.pry

  	erb :index
  end

  patch '/posts/:id' do
  	@post = Post.find(params[:id])

  	@post.update(name: params[:name]) unless params[:name].empty?
  	@post.update(content: params[:content]) unless params[:content].empty?
  	# binding.pry

  	erb :show
  end

  delete '/posts' do
  	post = Post.find(params[:id])

  	post.destroy

  	# binding.pry

  	@posts = Post.all

  	erb :index
  end
end
