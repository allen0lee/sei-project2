require 'sinatra'
require 'pry'
require 'sinatra/reloader'
require 'active_record'
require_relative 'db_config'
require_relative 'models/user.rb'
require_relative 'models/photo.rb'
require_relative 'models/comment.rb'
require_relative 'models/album.rb'
require_relative 'models/like.rb'
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
# login here
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
  @user_id = session[:user_id]
  erb :one_user_albums
end

# in user's own album page (or index after login), click 'create album' button, 
# go to create_album page - create_album.erb
get '/albums/:user_id/new' do
  redirect '/login' if !logged_in?
  @user_id = params[:user_id]
  erb :create_album
end
# create new album
post '/albums/:user_id' do         
  album = Album.new
  album.name = params[:name]         # params[] - get value from a route or get user input 
  album.theme_image_url = params[:theme_image_url]
  album.user_id = session[:user_id]
  if album.name != "" && album.theme_image_url != ""
    album.save
  end
  redirect "/albums/#{album.user_id}"
end

# show all photos of an album, with 'upload photo' button here - take user to upload_photo.erb
get '/photos/:album_name/:album_id' do
  @photos = Photo.where(album_id: params[:album_id])
  # need to determine the album owner, because 'upload photo' button is only visible to album owner 
  @album = Album.find_by(id: params[:album_id])
  @album_owner = User.find_by(id: @album.user_id).email

  @album_id = params[:album_id]
  @user_id = session[:user_id]     
  erb :photos
end

# go to upload photo page
get '/photos/:album_id/:user_id/new' do
  redirect '/login' if !logged_in?
  @album_id = params[:album_id]
  @user_id = session[:user_id]
  erb :upload_photo
end
# upload a photo                                
post '/photos/:album_id/:user_id' do          
  # album = Album.find_by(id: params[:album_id])
  album = Album.where(id: params[:album_id]).first
  photo = Photo.new
  photo.name = params[:name]
  photo.image_url = params[:image_url]
  # photo.user_id = session[:user_id]
  photo.user_id = params[:user_id]
  photo.album_id = album.id
  if photo.name != "" && photo.image_url != ""
    photo.save
  end
  # remove space in album name, otherwise route not known by browser
  redirect "/photos/#{(album.name).split(" ").join("")}/#{photo.album_id}"
end

# show single photo, likes and comments - create comments, add likes here
get '/photos/:id' do
  @photo = Photo.find(params[:id])
  # if a photo has no likes, create a new record in database
  if Like.find_by(photo_id: params[:id]) == nil
    @like = Like.new
    @like.number = 0
    @like.photo_id = params[:id]
    @like.save
  else # a photo has likes and can be found in table 'likes'
    @like = Like.find_by(photo_id: params[:id])
  end
  @comments = Comment.where(photo_id: @photo.id)
  erb :one_photo
end
# create a comment of a photo
post '/comments' do
  redirect '/login' if !logged_in? # if not logged in, cannot post a comment
  comment = Comment.new
  comment.content = params[:content]
  comment.photo_id = params[:photo_id]
  comment.user_id = session[:user_id]
  comment.time = Time.now.strftime("%d/%m/%Y %H:%M")
  if comment.content != ""
    comment.save
  end
  redirect "/photos/#{comment.photo_id}"
  # redirect "/photos/#{params[:photo_id]}"
end
# add likes to a photo - update likes
put '/likes' do
  like = Like.find_by(photo_id: params[:photo_id])
  like.photo_id = params[:photo_id]
  num_of_likes = like.number
  like.number = num_of_likes + 1
  like.save
  redirect "/photos/#{like.photo_id}"
end

# edit a photo
get '/photos/:id/:album_id/edit' do
  redirect '/login' if !logged_in? # if not logged in, cannot edit photo
  @photo = Photo.find(params[:id])
  erb :edit_photo
end
# update a photo 
put '/photos/:id' do
  photo = Photo.find(params[:id])
  photo.name = params[:name]
  photo.image_url = params[:image_url]
  photo.save
  redirect "/photos/#{photo.id}"
end
# delete a photo
delete '/photos/:id' do
  photo = Photo.find(params[:id])
  album = Album.where(id: photo.album_id).first
  photo.destroy
  redirect "/photos/#{(album.name).split(" ").join("")}/#{album.id}"
end

# delete an album





