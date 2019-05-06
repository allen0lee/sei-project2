# sei-project2

photo_sharing_app

In this app, users can register and create albums and photos. 
Albums and photos are named and described by their owners. 
Users can view other user's' albums. 
Users can comment on photos, or either up/down vote them.

data models:
1. users
2. albums
3. photos
4. comments
5. likes

'users' has relationship with 'albums', 'photos', and 'comments', which shares same 'user_id'.

'albums' has relationship with 'photos' and 'comments', which shares same 'album_id'.

'photos' has relationship with 'albums' and 'comments', which shares same 'photo_id'.

'comments' has relationship with users, 'photos', and 'albums', which shares same 'user_id' album_id', and'photo_id'.

'likes' has relationship with 'photos' and 'albums', which shares same 'album_id' and 'photo_id'.