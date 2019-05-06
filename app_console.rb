require 'pry'
require_relative 'db_config'

# more things here 

# lets tell the translation about our tables
require_relative 'models/photo.rb'
require_relative 'models/album.rb'
require_relative 'models/comment.rb'
require_relative 'models/user.rb'
require_relative 'models/like.rb'

binding.pry