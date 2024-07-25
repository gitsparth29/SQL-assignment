create database manufacturerdb;
use manufacturerdb;

# 1.4,1.9

CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,	
  Name VARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code), 
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
) ENGINE=INNODB;

INSERT INTO Manufacturers(Code,Name) 
		VALUES(1,'Sony'),
			  (2,'Creative Labs'),
			  (3,'Hewlett-Packard'),
			  (4,'Iomega'),
			  (5,'Fujitsu'),
			  (6,'Winchester');
              
INSERT INTO Products(Code,Name,Price,Manufacturer) 
		VALUES(1,'Hard drive',240,5),
			  (2,'Memory',120,6),
			  (3,'ZIP drive',150,4),
			  (4,'Floppy disk',5,6),
			  (5,'Monitor',240,1),
			  (6,'DVD drive',180,2),
			  (7,'CD drive',90,2),
			  (8,'Printer',270,3),
			  (9,'Toner cartridge',66,3),
			  (10,'DVD burner',180,2);
              

# 1.1 Select the names of all the products in the store.
select Name from Products;

#1.2 Select the names and the prices of all the products in the store.
select Name,Price from Products;

# 1.3 Select the name of the products with a price less than or equal to $200.
select Name from Products where Price <=200;

# 1.4 Select all the products with a price between $60 and $120.
select * from Products where Price >= 60 and price <=120; 
select * from Product where Price between 60 and 120;

# 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select Name,Price * 100 from Products;

# 1.6 Compute the average price of all the products.
select avg(Price) from Products;

# 1.7 Compute the average price of all products with manufacturer code equal to 2.
select avg(Price) from Products where Manufacturer=2;

# 1.8 Compute the number of products with a price larger than or equal to $180.
select count(*) from Products where Price >=180;

# 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), 
#and then by name (in ascending order).
select Name,Price from Products where Price>=180 order by Price desc, Name asc;

# 1.10 Select all the data from the products, including all the data for each product's manufacturer.
select * from 
	Products left join Manufacturers
    on Products.Manufacturer = Manufacturers.Code;
    
# 1.11 Select the product name, price, and manufacturer name of all the products.
  select  Products.Name, Price, Manufacturers.Name
   from Products inner join Manufacturers
   on Products.Manufacturer = Manufacturers.Code;
   
# 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
select avg(Price),Manufacturer from Products group by Manufacturer;

# 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
select avg(Price),Manufacturers.Products;

# 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
 select avg(Price), Manufacturers.Name
   from Products inner join Manufacturers
   on Products.Manufacturer = Manufacturers.Code
   group by Manufacturers.Name
   having avg(Price) >= 150;
   
# 1.15 Select the name and price of the cheapest product.
select Name,Price from Products order by Price asc limit 1;

# 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
select Name,Price from Products order by Price desc limit 1;

# 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
insert into Products( Code, Name , Price , Manufacturer)
  VALUES ( 11, 'Loudspeakers' , 70 , 2 );
  
# 1.18 Update the name of product 8 to "Laser Printer".
 update Products
   set Name = 'Laser Printer'
   where Code = 8;
  
# 1.19 Apply a 10% discount to all products.
 update Products
   set Price = Price - (Price * 0.1);
   
# 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
 update Products
   set Price = Price - (Price * 0.1)
   where Price >= 120;
   
SET SQL_SAFE_UPDATES = 0;
