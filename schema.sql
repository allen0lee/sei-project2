create database photo_sharing_app;

create table photos(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    image_url TEXT,
    -- image_file_name TEXT,
    user_id INTEGER,
    album_id INTEGER
    -- FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    -- FOREIGN KEY (album_id) REFERENCES albums (id) ON DELETE CASCADE
);
alter table photos add image_file_name text;

create table users(
    id SERIAL PRIMARY KEY,
    email VARCHAR(500) NOT NULL,
    password_digest VARCHAR(500) NOT NULL
);

create table comments(
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    time TEXT,
    photo_id INTEGER,
    album_id INTEGER,
    user_id INTEGER,
    user_email VARCHAR(500) NOT NULL
    -- FOREIGN KEY (photo_id) REFERENCES photos (id) ON DELETE CASCADE,
    -- FOREIGN KEY (album_id) REFERENCES albums (id) ON DELETE CASCADE,
    -- FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

create table albums(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    theme_image_url TEXT,
    -- theme_image_file_name TEXT,
    user_id INTEGER
    -- FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

create table likes(
    id SERIAL PRIMARY KEY,
    number INTEGER,
    photo_id INTEGER,
    album_id INTEGER
    -- FOREIGN KEY (photo_id) REFERENCES photos (id) ON DELETE CASCADE,
    -- FOREIGN KEY (album_id) REFERENCES albums (id) ON DELETE CASCADE
);