-- Create a table called Orders
CREATE TABLE Orders
(
    OrderID      INTEGER PRIMARY KEY,
    company_name TEXT NOT NULL,
    address      VARCHAR(100),
    city         TEXT,
    phone        INTEGER,
    order_date   DATE
);

-- Putting our values into Orders
INSERT INTO Orders
VALUES (1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '1 / 14 / 15'),
       (2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '5 / 2 / 15'),
       (3, 'Netflix', '888 Broadway', 'New York', '642-612-6123', '6 / 7 / 15');
-- double check values put into table correctly
SELECT *
FROM Orders;

-- Create a Query that will select company name, address, and city from the orders table for companies located in Chicago.
SELECT company_name, address, city
FROM Orders
WHERE city = 'Chicago';

-- Create a query that will select all the records for the Orders table where the company name start with an 'A'.
SELECT *
FROM Orders
WHERE company_name LIKE 'A%';

-- Remaining Questions will Use dBeaver Sample Database (music store).

-- Write a query that will list all of the genre names and a count of the tracks for each genre.
-- Sort the list by largest track count to smallest.
SELECT g.Name, COUNT(TrackId) AS TrackCount
FROM Genre g
         JOIN Track t
              ON g.GenreId = t.GenreId
GROUP BY g.Name
ORDER BY TrackCount DESC;

-- Write a query that will list all of the track names and the album names from the artist named 'Jamiroquai'.
SELECT t.Name, a.Title
FROM Track t
         LEFT JOIN Album a
                   ON t.AlbumId = a.AlbumId
         LEFT JOIN Artist a2
                   ON a.ArtistId = a2.ArtistId
WHERE a2.Name = 'Jamiroquai';

-- Write a query that will determine the top 5 countries measured by total revenue (dollars) sold by Billing Country.
-- Include Country and Total Revenue
SELECT BillingCountry, SUM(Total) AS TotalRevenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalRevenue DESC
LIMIT 5;

-- Write a query that determines the total sales by global region.
-- Use 'Asia Pacific' for India and Australia
-- Use 'North America' for Canada and the USA
-- Use 'South america' for Chile, Brazil, and Argentina
-- Use 'Europe' for the rest

SELECT CASE
           WHEN BillingCountry IN ('India', 'Australia') THEN 'Asia Pacific'
           WHEN BillingCountry IN ('Canada', 'USA') THEN 'North America'
           WHEN BillingCountry IN ('Chile', 'Brazil', 'Argentina') THEN 'South America'
           ELSE 'Europe' END AS GlobalRegion,
       SUM(Total)            AS TotalSales
FROM Invoice
GROUP BY GlobalRegion
ORDER BY TotalSales DESC;


-- Write a Query that lists the artists that don't have albums.
SELECT a.Name, A2.AlbumId
FROM Artist a
         LEFT JOIN Album a2
                   ON a.ArtistId = a2.ArtistId
WHERE a2.AlbumId IS NULL;

-- Write a query that lists:
-- all the invoice amounts
-- their billing country
-- and total amount of revenue from that country
-- Sort Largest to Smallest
SELECT InvoiceId,
       Total,
       BillingCountry,
       SUM(Total) OVER (PARTITION BY BillingCountry) AS CountryRevenue
FROM Invoice
ORDER BY CountryRevenue DESC;








