TABLE IF EXISTS tracks CASCADE;
TABLE IF EXISTS albums CASCADE;
TABLE IF EXISTS albums_tracks CASCADE;

CREATE TABLE tracks (
track_id serial PRIMARY KEY,
song_title text NOT NULL,
length TIME NOT NULL,
views int NOT NULL,
created_at timestamp with time zone NOT NULL DEFAULT NOW()

);


CREATE TABLE albums (
album_id serial PRIMARY KEY,
title text NOT NULL,
length TIME NOT NULL,
sales int NOT NULL,
created_at timestamp with time zone NOT NULL DEFAULT NOW()

);

INSERT INTO tracks (song_title,length,views)
  VALUES ('Collateral Damage',TIME '00:03:17', 200214800),
       ('On the low', '00:03:06', 200891281),
       ('Passion Fruit', TIME'00:04:58',1246071475 ),
       ('Fake love', TIME ' 3:30',889767072),
       ('Jam (feat. Wizkid)', TIME '3:18', 22147240),
       ('Ease your mind',TIME '3:05', 1219173),
       ('Darker shade of black', TIME'00:02:50', 2323543 ),
       ('NIC', TIME  '00:03:40',19729938 ),
       ('Loading', TIME '00:03:19', 255483174 ),
       ('West Ham', TIME '00:03:14',826105 ),
       ('Starlight', TIME '00:03:31', 672783345),
       ('Rapstar', TIME '00:02:34', 731693905),
       ('Calm down', TIME '00:03:39', 304463303);

INSERT INTO albums (title, length, sales)
VALUES ('African Giant', TIME '01:00:00', 60000 ),
       ('Soundman vol.1', TIME '00:24:09', 5000 ),
       ( 'ALL Our Yesterdays',TIME '01:05:00', 2500 ),
       ('NAtures light', TIME '1:50:00', 2000),
       ('Crabs in a bucket', TIME '00:52:05', 100000),
       ('Wild West', TIME '00:38:32', 100000),
       ('c2c', TIME '00:20:21',10000),
       ('PSYCHODRAMA', TIME '00:51:10', 300000),
       ('HAll of fame', TIME '00:54:14' , 1000000),
       ('Rave and Roses', TIME '00:59:09' ,1000000000);

CREATE TABLE albums_tracks (
albums_tracks_id serial PRIMARY KEY,
created_at timestamp with time zone NOT NULL DEFAULT NOW(),
album_id int REFERENCES albums (album_id),
track_id int REFERENCES tracks (track_id)
);

INSERT INTO albums_tracks (track_id, album_id)
VALUES (1,1),
(2,1),
(3,2),
(4,2),
(5,3),
(6,3),
(7,4),
(7,5),
(8,6),
(9,6),
(10,7),
(11,8),
(12,9),
(13,10);


SELECT  albums.title AS "Albums", tracks.song_title AS "tracks"
       FROM albums 
        INNER JOIN albums_tracks 
        ON albums.album_id = albums_tracks.album_id
        INNER JOIN tracks
        ON albums_tracks.track_id = tracks.track_id;

 SELECT tracks.song_title AS "tracks", albums.title AS "Albums"
       FROM tracks 
        INNER JOIN albums_tracks 
        ON tracks.track_id = albums_tracks.track_id
       INNER JOIN albums
      ON albums_tracks.album_id = albums.album_id;

        SELECT albums.album_id,
               albums.title,
               COUNT (tracks.track_id) AS num_songs
               FROM albums
               INNER JOIN albums_tracks
              ON albums.album_id = albums_tracks.album_id
               INNER JOIN tracks
              ON albums_tracks.track_id= tracks.track_id
              GROUP BY albums.album_id, albums.title
              ORDER BY albums.album_id ASC;

SELECT tracks.track_id, 
       tracks.song_title ,
       COUNT (albums.album_id) AS num_albums
        FROM tracks 
        INNER JOIN albums_tracks 
        ON tracks.track_id = albums_tracks.track_id
        INNER JOIN albums
        ON albums_tracks.album_id = albums.album_id    
         GROUP BY tracks.track_id , tracks.song_title
         ORDER BY tracks.track_id ASC;