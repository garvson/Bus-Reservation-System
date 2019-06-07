DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Employee_Entry`(empID INT, name Varchar (32), address Varchar (64), email Varchar (16), tel Varchar (16), branch INT)
BEGIN
	INSERT INTO Employee (EmpID,Name,Address,Email,Tel,Branch) VALUES (empid,name,address,email,tel,branch);
END$$
DELIMITER ;
