DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Customer_Entry`(custID INT,name Varchar (45),address Varchar(65),age INT,contacts INT)
BEGIN
	INSERT INTO Customers(CustID,Name,Address,Age,Contacts) VALUES (custid,name,address,age,contacts);
END$$
DELIMITER ;
