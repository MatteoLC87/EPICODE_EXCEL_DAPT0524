CREATE TABLE STORE (
CodiceStore INT NOT NULL,
IndirizzoFisico VARCHAR(25),
NumeroTelefono CHAR(14),
CONSTRAINT PK_STORE PRIMARY KEY (CodiceStore));

ALTER TABLE STORE
MODIFY COLUMN IndirizzoFisico VARCHAR(100);


CREATE TABLE IMPIEGATO (
CodiceFiscale CHAR(16) NOT NULL,
Nome VARCHAR(25),
TitoloStudio VARCHAR(40),
Recapito VARCHAR(40),
CONSTRAINT PK_IMPIEGATO PRIMARY KEY (CodiceFiscale));

CREATE TABLE VIDEOGIOCO (
CodiceVideogioco INT NOT NULL,
Titolo VARCHAR(25),
Sviluppatore VARCHAR(25),
AnnoDistribuzione YEAR,
CostoAcquisto DECIMAL(5,2),
Genere VARCHAR(25),
RemakeDi VARCHAR(25),
CONSTRAINT PK_VIDEOGIOCO PRIMARY KEY (CodiceVideogioco));

ALTER TABLE VIDEOGIOCO
MODIFY COLUMN CodiceVideogioco INT NOT NULL AUTO_INCREMENT;

ALTER TABLE VIDEOGIOCO
MODIFY COLUMN Titolo VARCHAR(100);


CREATE TABLE SERVIZIO_IMPIEGATO (
CodiceFiscale CHAR(16) NOT NULL,
CodiceStore INT NOT NULL,
DataInizio DATE,
DataFine DATE,
Carica VARCHAR(25),
CONSTRAINT FK_IMPIEGATO_SERVIZIO_IMPIEGATO FOREIGN KEY (CodiceFiscale)
REFERENCES IMPIEGATO(CodiceFiscale),
CONSTRAINT FK_STORE_SERVIZIO_IMPIEGATO FOREIGN KEY (CodiceStore)
REFERENCES STORE(CodiceStore),
CONSTRAINT PK_SERVIZIO_IMPIEGATO PRIMARY KEY (CodiceFiscale, CodiceStore));

CREATE TABLE COLLOCAZIONE_VIDEOGIOCO (
CodiceVideogioco INT NOT NULL,
CodiceStore INT NOT NULL,
Quantità SMALLINT,
CONSTRAINT FK_VIDEOGIOCO_COLLOCAZIONE_VIDEOGIOCO FOREIGN KEY (CodiceVideogioco)
REFERENCES VIDEOGIOCO(CodiceVideogioco),
CONSTRAINT FK_STORE_COLLOCAZIONE_VIDEOGIOCO FOREIGN KEY (CodiceStore)
REFERENCES STORE(CodiceStore),
CONSTRAINT PK_COLLOCAZIONE_VIDEOGIOCO PRIMARY KEY (CodiceVideogioco, CodiceStore));

INSERT INTO STORE VALUES
(1,'Via Roma 123, Milano Corso','+39 021234567'),
(2,'Italia 456, Roma Piazza','+39 067654321'),
(3,'San Marco 789, Venezia','+39 0419876543'),
(4,'Viale degli Ulivi 234, Napoli','+39 0813456789'),
(5,'Via Torino 567, Torino','+39 0118765432'),
(6,'Corso Vittorio Emanuele 890, Firenze','+39 0552345678'),
(7,'Piazza del Duomo 123, Bologna','+39 0518765432'),
(8,'Via Garibaldi 456, Genova','+39 0102345678'),
(9,'Lungarno Mediceo 789, Pisa','+39 0508765432'),
(10,'Corso Cavour 101, Palermo','+39 0912345678');

SELECT*
FROM STORE;


INSERT INTO IMPIEGATO VALUES
('ABC12345XYZ67890','Mario Rossi','Laurea in Economia','mario.rossi@email.com'),
('DEF67890XYZ12345','Anna Verdi','Diploma di Ragioneria','anna.verdi@email.com'),
('GH112345XYZ67890','Luigi Bianchi','Laurea in Informatica','luigi.bianchi@email.com'),
('JKL67890XYZ12345','Laura Neri','Laurea in Lingue','laura.neri@email.com'),
('MN012345XYZ67890','Andrea Moretti','Diploma di Geometra','andrea.moretti@email.com'),
('PQR67890XYZ12345','Giulia Ferrara','Laurea in Psicologia','giulia.ferrara@email.com'),
('STU12345XYZ67890','Marco Esposito','Diploma di Elettronica','marco.esposito@email.com'),
('VWX67890XYZ12345','Sara Romano','Laurea in Giurisprudenza','sara.romano@email.com'),
('YZA12345XYZ67890','Roberto De Luca','Diploma di Informatica','roberto.deluca@email.com'),
('BCD67890XYZ12345','Elena Santoro','Laurea in Lettere','elena.santoro@email.com');

SELECT*
FROM IMPIEGATO;

INSERT INTO VIDEOGIOCO VALUES
(1,'Fifa 2023','EA Sports',2023,49.99, 'Calcio',NULL),
(2,"Assassin's Creed: Valhalla",'Ubisoft',2020,59.99, 'Action',NULL),
(3,'Super Mario Odyssey','Nintendo',2020,39.99, 'Platform',NULL),
(4,'The Last of Us Part II','Naughty Dog',2020,69.99, 'Action',NULL),
(5,'Cyberpunk 2077','CD Projekt Red',2020,49.99, 'RPG',NULL),
(6,'Animal Crossing: New Horizons','Nintendo',2020,54.99, 'Simulation' ,NULL),
(7,'Call of Duty: Warzone','Infinity Ward',2020,0.00, 'FPS',NULL),
(8,'The Legend of Zelda: Breath of the Wild','Nintendo',2020,59.99, 'Action-Adventure',NULL),
(9,'Fortnite','Epic Games',2020,0.00, 'Battle Royale',NULL),
(10,'Red Dead Redemption 2','Rockstar Games',2020,39.99, 'Action-Adventure',NULL);

SELECT*
FROM VIDEOGIOCO;


INSERT INTO SERVIZIO_IMPIEGATO VALUES
("ABC12345XYZ67890",1,"2023-01-01","2023-12-31","Cassiere"),
("DEF67890XYZ12345",2,"2023-02-01","2023-11-30","Commesso"),
("GH112345XYZ67890",3,"2023-03-01","2023-10-31","Magazziniere"),
("JKL67890XYZ12345",4,"2023-04-01","2023-09-30","Addetto alle vendite"),
("MN012345XYZ67890",5,"2023-05-01","2023-08-31","Addetto alle pulizie"),
("PQR67890XYZ12345",6,"2023-06-01","2023-07-31","Commesso"),
("STU12345XYZ67890",7,"2023-07-01","2023-06-30","Commesso"),
("VWX67890XYZ12345",8,"2023-08-01","2023-05-31","Cassiere"),
("YZA12345XYZ67890",9,"2023-09-01","2023-04-30","Cassiere"),
("BCD67890XYZ12345",10,"2023-10-01","2023-03-31","Cassiere");



INSERT INTO COLLOCAZIONE_VIDEOGIOCO VALUES
(1,1,5),
(2,2,7),
(3,3,1),
(4,4,2),
(5,5,12),
(6,6,4),
(7,7,3),
(8,8,6),
(9,9,5),
(10,10,10);

SELECT *
FROM COLLOCAZIONE_VIDEOGIOCO




