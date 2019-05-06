class User < ActiveRecord::Base
    has_secure_password # add a few methods for you to the User class

    # .password is going to hash your password and store it in password_digest column

    # .authenticate()
end