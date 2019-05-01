require 'pg'
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'photo_sharing_app'
}

ActiveRecord::Base.establish_connection(options)