CREATE TABLE videos(
  id serial8 primary key, 
  title varchar(225),
  description text,
  url varchar(225),
  genre varchar(30)
);

INSERT INTO VIDEOS (title, description, url,	genre) VALUES ('Point Break', 'official trailer', 'ncvFAm4kYCo', 'film')