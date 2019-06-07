Create database BusReservationSystem;

use BusReservationSystem;

CREATE TABLE BusType
(
	BusId INT NOT NULL PRIMARY KEY,
	BusNo INT NOT NULL
);

INSERT INTO BusType
(BusId, BusNo)
Values
(2,1235);

select * from bustype;


CREATE TABLE Route
(
	RouteID INT NOT NULL PRIMARY KEY,
	BusStop Varchar(45) NOT NULL,
	RouteCode Varchar(16) NOT NULL UNIQUE
);



INSERT INTO Route
(RouteID, Busstop, RouteCode)
VALUES
(12, "Boston", "BO12");

select * from Route;

CREATE TABLE BusFare(
FareId INT NOT NULL PRIMARY KEY,
Route INT,
BusFare int NOT NULL Check (BusFare >0),
CONSTRAINT fk_Route FOREIGN KEY (Route) REFERENCES
Route(RouteID)
);


INSERT INTO BusFare
(FareId, Route, Busfare)
VALUES
(112, 12, 238);

select * from Busfare;

CREATE TABLE BusSchedule(
SchedID INT,
ScheduledDate DATETIME,
FromCity varchar(32),
ToCity varchar(32),
Bustype INT,
NetBusFare INT,
PRIMARY KEY (SchedID),
CONSTRAINT fk_Bustype FOREIGN KEY (Bustype) REFERENCES
BusType(BusId),
CONSTRAINT fk_NetBusFare FOREIGN KEY (NetBusFare) REFERENCES
BusFare(FareId)
);

insert into busschedule
(SchedID,ScheduledDate,FromCity,ToCity,BusType,NetBusFare)
VALUES
(142,'2017-12-19','Boston','NewYork',1,112);

select *from busschedule;



CREATE TABLE Discounts(
DiscountID INT PRIMARY KEY,
Description Varchar(32),
Amount INT
);

INSERT INTO discounts
Values
(13,'Discount for below 15',30);

select *from discounts;

CREATE TABLE Penalty(
PenaltyID INT PRIMARY KEY,
Descrip Varchar(32),
Amt INT
);

INSERT INTO penalty
Values
(14,'Cancellations',45);

select *from penalty;


CREATE TABLE States (
StateID INT PRIMARY KEY,
StateName Varchar (45) NOT NULL
);

INSERT into States
values
(100, 'MA');

select *from States;


CREATE TABLE Cities(
CityID INT,
CityName Varchar (32),
State INT,
PRIMARY KEY (CityID),
CONSTRAINT fk_State FOREIGN KEY (State) REFERENCES
States(StateID)
);

INSERT INTO Cities
VALUES
(20,'Andover',100);

select *from Cities;


CREATE TABLE ContactDetails(
ContID INT PRIMARY KEY,
Email Varchar (16) NOT NULL,
Telephone Varchar (16),
City INT NOT NULL,
CONSTRAINT fk_City FOREIGN KEY (City) REFERENCES Cities(CityID)
);

INSERT INTO ContactDetails
VALUES
(135,'abcd@gmail.com','85766756789',20);

select *from contactdetails;


CREATE TABLE Customers(
CustID INT PRIMARY KEY,
Name Varchar (45) NOT NULL,
Address Varchar (64) NOT NULL,
Age INT CHECK (Age>=18),
Contacts INT NOT NULL,
CONSTRAINT fk_Contact FOREIGN KEY (Contacts) REFERENCES
ContactDetails(ContID)
);

INSERT INTO Customers
VALUES
(23,'Chetan M Jadhav','11 Tetlow Street, BOSTON, MA 02115',26,133);

select *from Customers;


CREATE TABLE Branches(
BranchID INT PRIMARY KEY,
Center Varchar(16) NOT NULL,
Address Varchar(32) NOT NULL,
Cityy INT,
CONSTRAINT fk_AgentCity FOREIGN KEY (Cityy) REFERENCES
Cities(CityID)
);

INSERT INTO Branches
VALUES
(50,'Andover','360 Huntington Ave',20);

select *from Branches;


CREATE TABLE Employee
(
EmpID INT PRIMARY KEY,
Name Varchar (32) NOT NULL,
Address Varchar (64) NOT NULL,
Email Varchar (16) NOT NULL,
Tel Varchar (16) NOT NULL,
Branch INT NOT NULL,
CONSTRAINT fk_Branch FOREIGN KEY (Branch) REFERENCES
Branches(BranchID)
);


INSERT INTO Employee
VALUES
(36,'Lionel','232 CityView Apt, ANdover, MA, 02116','xyrz@gmail.com','123445768',50);

select *from employee;


CREATE TABLE Reservations(
BookingID INT PRIMARY KEY,
BookingDate DATE,
DepartureDate DATE,
Type BIT,
TotalFare INT,
Customer INT,
Bus INT,
Employee INT,
Penaltyy INT,
Discount INT,
CONSTRAINT fk_Customer FOREIGN KEY (Customer) REFERENCES
Customers (CustID),
CONSTRAINT fk_Bus FOREIGN KEY (Bus) REFERENCES
BusSchedule (SchedID),
CONSTRAINT fk_Employee FOREIGN KEY (Employee) REFERENCES
Employee(EmpID),
CONSTRAINT fk_Penalty FOREIGN KEY (Penaltyy) REFERENCES
Penalty(PenaltyID),
CONSTRAINT fk_Discount FOREIGN KEY (Discount) REFERENCES
Discounts(DiscountID)
);


select *from reservations;

INSERT INTO Reservations
(BookingID,BookingDate,DepartureDate,Type,Customer,Bus,Employee,penaltyy,Discount)
Values
(1236,'2017-12-15','2017-12-23',0,25,142,37,14,null);




CREATE TABLE Refund(
RefundID INT NOT NULL primary key,
Descrptn Varchar(32),
Amount INT,
RefundStatus varchar(60),
BookingID INT,
CONSTRAINT fk_Reservation FOREIGN KEY (BookingID) REFERENCES
Reservations (BookingID)
);




CALL `busreservationsystem`.`Customer_Entry`(25, 'Shravan Boosanur', '11 Tetlow', 26, 136);

Select *from bustype;
select *from route;
Select *from busfare;
Select *from busschedule;
Select *from discounts;
Select *from penalty;
Select *from states;
select *from cities;
Select *from contactdetails;
select *from customers;
Select *from branches;
Select *from employee;
Select *from reservations;



CALL `busreservationsystem`.`Employee_Entry`(37, 'Ricardo Kaka', '232 westcott Street Syracuse', 'dajh@xyz.com', 978738974723, 51);



delimiter %%
create trigger tr before insert on reservations
for each row
begin

if(new.discount is not null) then
set new.totalfare=((select b.BusFare from busfare b, busschedule bs where bs.SchedID=new.bus and bs.NetBusFare=b.Fareid)-
(select amount from discounts where Discountid=new.discount));
end if;
end %%
delimiter ;



drop trigger tr;




delimiter %%
create trigger tr_cancel before insert on reservations
for each row
begin

if(new.penaltyy is not null) then
set new.totalfare=((select b.BusFare from busfare b, busschedule bs where bs.SchedID=new.bus and bs.NetBusFare=b.Fareid)-
(select Amt from penalty where PenaltyID=new.penaltyy));
end if;
end %%
delimiter ;





