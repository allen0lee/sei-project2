require 'sinatra'
require 'pry'
require 'sinatra/reloader'
require 'active_record'
require_relative 'db_config'
require_relative 'models/user.rb'
require_relative 'models/photo.rb'
require_relative 'models/comment.rb'
require_relative 'models/album.rb'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end

# index page
get '/' do       
  erb :index
end

# login page
get '/login' do
  erb :login
end

post '/session' do                                
  user = User.find_by(email: params[:email])      
  if user && user.authenticate(params[:password]) # login successfully
    session[:user_id] = user.id                              
    redirect '/'
  else # login fail
    erb :login
  end
end

# click logout button -- delete the session
delete '/session' do
  session[:user_id] = nil
  redirect '/'
end

# page that lists all users' albums - albums.erb
get '/albums' do
  @albums = Album.all
  erb :albums
end

# page that lists one user's albums
get '/albums/:user_id' do
  @albums = Album.where(user_id: params[:user_id])
  erb :one_user_albums
end

# in user's own album page (or index after login), click 'create album' button, 
#go to create_album page - new_album.erb
get '/albums/:user_id/new' do
  # redirect '/login' if !logged_in?
  @user_id = User.find(params[:user_id])
  erb :new_album
end
# create new album here
post '/albums' do
  album = Album.new
  album.name = params[:name]
  album.theme_image_url = params[:theme_image_url]
  album.user_id = session[:user_id]
  album.save
  redirect "/albums/#{album.user_id}"
  # redirect 'albums'
end

# show all photos of an album - upload photo here
get '/:album_name/:album_id/photos' do
  # "hello"
  @photos = Photo.where(album_id: params[:album_id])
  erb :photos
end

# upload a photo
post '' do

end

# single photo and comments - create comments here

# delete an album

# edit comment

# delete photo

