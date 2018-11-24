require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "Hello World"
  end

  ################################################################################
  #CREATE 1:
  #1st step is to get and display the form
    get '/posts/new' do
      erb:new
    end

  #CREATE 2:
  #2nd step is to
  # send a POST request to another controller action, post '/posts'.
  # It is here that you place the code that extracts the form data
  #from the params and use it to create a new instance of your model class
    post '/posts' do
      @post=Post.create(name:params[:name], content: params[:content])
      @posts=Post.all
      erb:index
    end
  ################################################################################



################################################################################
  # SHOW ALL: AKA INDEX
  # Create the get '/posts' controller action.
  # This action should use Active Record to grab all of the posts and
  # store them in an instance variable, @posts.
  # Then, it should render the index.erb view.
  # That view should use erb to iterate over @posts and render them on the page.

    get '/posts' do
      @posts = Post.all
      erb :index
    end
################################################################################




################################################################################
# SHOW ONE INSTANCE: AKA SHOW
# Create the get '/posts/:id' controller action.
# This action should use Active Record to grab the
# post with the id that is in the params and set it equal to @post.
# Then, it should render the show.erb view page.
# That view should use erb to render the @post's title and content.
get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :show
end
################################################################################




################################################################################
#UPDATE/EDIT
# The Update CRUD action corresponds to the edit controller action and view.
# Create a controller action, get '/posts/:id/edit', that renders the view, edit.erb.
#This view should contain a form to update a specific blog post and POSTs to a controller action, patch '/posts/:id'.
# You'll need to make sure the edit form includes:
#STEP 1 is a get
get '/posts/:id/edit' do
  @post=Post.find(params[:id])
  erb :edit
end

#STEP 2 is a patch

patch '/posts/:id' do
  @post=Post.update(name:params[:name], content: params[:content])
  redirect "/posts/#{@post.id}"
end
################################################################################




################################################################################
#DELETE

delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.delete
    erb :delete
  end
################################################################################


end #END OF CLASS
