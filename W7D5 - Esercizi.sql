-- es1
-- Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce.

SELECT
g.Name
,SUM(t.TrackId) 'numero tracce'
FROM track t
INNER JOIN genre g
ON t.GenreId = g.GenreId
GROUP BY g.GenreId
HAVING SUM(t.TrackId) >= 10;

-- es2
-- Trovate le tre canzoni più costose.

SELECT
TrackId
,Name
,AlbumId
,UnitPrice
FROM track
ORDER BY UnitPrice DESC
LIMIT 3; -- sono più di 3

-- es 3 
-- Elencate gli artisti che hanno canzoni più lunghe di 6 minuti.


SELECT DISTINCT
artist.Name
FROM artist
INNER JOIN album
ON artist.ArtistId = album.ArtistId
INNER JOIN track
ON track.AlbumId = album.AlbumId
WHERE Milliseconds > 6*60*1000 AND Composer IS NOT NULL;

/*
TrackId
,Name
,ROUND(Milliseconds/60/1000,2) minuti
*/

-- es 4
-- Individuate la durata media delle tracce per ogni genere.

SELECT
g.Name
,ROUND(AVG(Milliseconds)/60/1000,2) 'durata media min'
FROM track t
INNER JOIN genre g
ON t.GenreId = g.GenreId
GROUP BY g.GenreId;

-- es 5
-- Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome.

SELECT
t.Name 'nome traccia'
,g.Name genere
FROM track t
INNER JOIN genre g
ON g.GenreId = t.GenreId
WHERE t.Name LIKE '%love%'
ORDER BY g.Name ASC, t.Name;

-- es 6
-- trovate il costo medio per ogni tipologia di media

SELECT
m.Name 'tipologia di media'
,AVG(UnitPrice) 'prezzo medio'
FROM mediatype m
INNER JOIN track t
ON m.MediaTypeId = t.MediaTypeId
GROUP BY m.MediaTypeId;

-- es7
-- Individuate il genere con più tracce.

SELECT
g.Name
,SUM(t.TrackId) 'numero tracce'
FROM track t
INNER JOIN genre g
ON t.GenreId = g.GenreId
GROUP BY g.GenreId
ORDER BY SUM(t.TrackId) DESC
LIMIT 1;


-- es 8
-- Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.

SELECT *
FROM artist
WHERE Name LIKE 'rolling stones';

SELECT *
FROM album;


-- es 9
-- Trovate l’artista con l’album più costoso.

SELECT
album.Title album
,SUM(UnitPrice) prezzo
FROM artist
INNER JOIN album
ON artist.ArtistId = album.ArtistId
INNER JOIN track
ON track.AlbumId = album.AlbumId
GROUP BY album.AlbumId
ORDER BY SUM(UnitPrice) DESC
LIMIT 1;







