CREATE DATABASE Kitabxana

use Kitabxana

CREATE TABLE Books
(
Id INT IDENTITY PRIMARY KEY,
	Name nvarchar(100),
	PageCount nvarchar(100),
)

CREATE TABLE Authors(
Id INT IDENTITY PRIMARY KEY,
Name nvarchar(20),
Surname nvarchar(20)
)

ALTER TABLE Books
ADD AuthorId INT FOREIGN KEY REFERENCES Authors(Id)


SELECT * FROM Books
SELECT * FROM Authors

INSERT INTO Authors 
VALUES
('Fyodor','Dostoyevski'),
('Alber','Kamyu'),
('Ceyn','Ostin'),
('Con','Steynbek '),
('Lev','Tolstoy'),
('Corc','Oruell')

INSERT INTO Books
VALUES
('1984',230,6),
('Anna Karenina',320,5),
('Cinayət və cəza',154,1),
('Yad',166,2),
('Qürur və qərəz',270,3),
('Qəzəb salxımları',324,4)

--*************************************************************

UPDATE Books
SET Name='Cinayet ve ceza'
WHERE Books.Id=3

UPDATE Books
SET Name='Qurur ve qerez'
WHERE Books.Id=5

UPDATE Books
SET Name='Qezeb salximlari'
WHERE Books.Id=6
--*************************************************************



SELECT * FROM
(SELECT Books.Name AS 'Kitabin adi',Books.PageCount AS 'Seyfesi',Authors.Name +' '+Authors.Surname AS 'Fullname' FROM Books
FULL JOIN Authors ON Books.AuthorId=Authors.Id
UNION
SELECT Books.Name AS 'Kitabin adi',PageCount AS 'Seyfesi',Authors.Name +' '+Authors.Surname AS 'Fullname' FROM Authors
JOIN Books ON Authors.Id=Books.AuthorId) AS Kitab
WHERE Kitab.Seyfesi>100

--*************************************************************
--*************************************************************


CREATE VIEW VW_Kitablar
AS
SELECT Books.Name AS 'Kitabin adi',Books.PageCount AS 'Seyfesi',Authors.Name +' '+Authors.Surname AS 'Fullname' FROM Books
FULL JOIN Authors ON Books.AuthorId=Authors.Id
UNION
SELECT Books.Name AS 'Kitabin adi',PageCount AS 'Seyfesi',Authors.Name +' '+Authors.Surname AS 'Fullname' FROM Authors
JOIN Books ON Authors.Id=Books.AuthorId



--*************************************************************
--*************************************************************

SELECT * FROM VW_Kitablar


CREATE PROCEDURE USP_Kitablar 
@search NVARCHAR(20)
AS
SELECT * FROM VW_Kitablar
WHERE VW_Kitablar.[Kitabin adi] LIKE '%'+@search+'%' OR Fullname LIKE '%'+@search+'%'

EXEC USP_Kitablar 'Q'

--*************************************************************
--*************************************************************

SELECT * FROM VW_Kitablar

CREATE PROCEDURE USP_KitabElave
@name NVARCHAR(20),
@surname NVARCHAR(20)
AS
INSERT INTO Authors(Name,Surname)
VALUES (@name,@surname)

EXEC USP_KitabElave 'Qustav','Flober'

--*************************************************************
--*************************************************************



ALTER VIEW VW_Kitablar
AS
SELECT Authors.Id, Books.Name AS 'Kitabin adi',Books.PageCount AS 'Seyfesi',Authors.Name +' '+Authors.Surname AS 'Fullname' FROM Books
FULL JOIN Authors ON Books.AuthorId=Authors.Id
UNION
SELECT Authors.Id,Books.Name AS 'Kitabin adi',PageCount AS 'Seyfesi',Authors.Name +' '+Authors.Surname AS 'Fullname' FROM Authors
JOIN Books ON Authors.Id=Books.AuthorId

--*************************************************************
--*************************************************************

SELECT * FROM VW_Kitablar

CREATE PROCEDURE USP_KitabUpd
@name NVARCHAR(20),
@surname NVARCHAR(20),
@id INT
AS

UPDATE Authors
SET Authors.Name=@name,Authors.Surname=@surname
WHERE Authors.Id=@id



EXEC USP_KitabUpd 'Viktor','Huqo ',7

--*************************************************************
--*************************************************************

SELECT * FROM VW_Kitablar


CREATE PROCEDURE USP_KitabDel
@id INT

AS

DELETE FROM Authors WHERE Authors.Id=@id

EXEC USP_KitabDel 7



