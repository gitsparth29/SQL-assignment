create database sql_assignment_5;
use sql_assignment_5;

# 3,5,6

CREATE TABLE Pieces (
 Code INTEGER PRIMARY KEY NOT NULL,
 Name TEXT NOT NULL
 );
 
CREATE TABLE Providers (
 Code VARCHAR(40) 
 PRIMARY KEY NOT NULL,  
 Name TEXT NOT NULL 
 );
 
CREATE TABLE Provides (
 Piece INTEGER, 
 FOREIGN KEY (Piece) REFERENCES Pieces(Code),
 Provider VARCHAR(40), 
 FOREIGN KEY (Provider) REFERENCES Providers(Code),  
 Price INTEGER NOT NULL,
 PRIMARY KEY(Piece, Provider) 
 );

# alternative one for SQLite
 
 /* CREATE TABLE Provides (
 Piece INTEGER,
 Provider VARCHAR(40),  
 Price INTEGER NOT NULL,
 PRIMARY KEY(Piece, Provider) 
 ); */
 
INSERT INTO Providers(Code, Name) 
					VALUES('HAL','Clarke Enterprises'),
						  ('RBT','Susan Calvin Corp.'),
						  ('TNBC','Skellington Supplies');

INSERT INTO Pieces(Code, Name) 
				VALUES(1,'Sprocket'),
					  (2,'Screw'),
					  (3,'Nut'),
					  (4,'Bolt');

 INSERT INTO Provides(Piece, Provider, Price) 
					VALUES(1,'HAL',10),
						  (1,'RBT',15),
						  (2,'HAL',20),
						  (2,'RBT',15),
						  (2,'TNBC',14),
						  (3,'RBT',50),
						  (3,'TNBC',45),
						  (4,'HAL',5),
						  (4,'RBT',7);
                          
# 5.1 Select the name of all the pieces. 
select Name from Pieces;

# 5.2  Select all the providers' data. 
select * from Providers;

# 5.3 Obtain the average price of each piece (show only the piece code and the average price).
select Price, avg(Price) from Provides;

# 5.4  Obtain the names of all providers who supply piece 1.
select Name from Providers
  where Code in (select Provider from Provides where Piece = 1);
# 5.5 Select the name of pieces provided by provider with code "HAL".
select Name from Piece
  where Code in (select Piece from Provides where Provides = "HAL");	
# 5.6
# ###############
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Interesting and important one.
# For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
# (note that there could be two providers who supply the same piece at the most expensive price).
# ###############
# 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
insert into Provides values (1, 'TNBC', 7);
 
# 5.8 Increase all prices by one cent.
set SQL_SAFE_UPDATES = 0;
update Provides set Price = Price + 1;

# 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
delete from Provides
   where Provider = 'RBT' and Piece = 4;
   
# 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    # (the provider should still remain in the database).
 delete from Provides
   where Provider = 'RBT';