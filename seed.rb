require 'pry'
require_relative 'db_config'

require_relative 'models/photo.rb'
require_relative 'models/album.rb'
require_relative 'models/comment.rb'
require_relative 'models/user.rb'
require_relative 'models/like.rb'


# user = User.new
# user.email = 'alan@test.com'
# user.password = '123'
# user.save

8.times do
  album = Album.new
  album.name = 'pokeball'
  album.theme_image_url = 'http://pngimg.com/uploads/pokeball/pokeball_PNG21.png'
  album.user_id = 11
  album.save
end