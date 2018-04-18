--#1
SELECT CustomerFirst, CustomerLast, AddressType, StateCode, City, ZipCode, CustomerType from

(SELECT Private_Customer.customerFirstName as CustomerFirst, Private_Customer.customerLastName as CustomerLast, 'Home' as AddressType, Private_Customer.stateCode as StateCode,
	Private_Customer.city as City, Private_Customer.zipCode as ZipCode, 'Private' as CustomerType from Private_Customer

UNION

SELECT Corporate_Customer.corporationName as CustomerFirst, 'N/A' as CustomerLast, Address.AddressType as AddressType, Address.stateCode as StateCode,
	Address.city, Address.zipCode as ZipCode, 'Corporate' as CustomerType from Corporate_Customer INNER JOIN Address using (customerID)
)t1 ;	


--#2
SELECT MainCustomerInfo, ExtraCustomerInfo, AppointmentNumber, TotalCost from

(SELECT Private_Customer.customerFirstName as MainCustomerInfo, Private_Customer.customerLastName as ExtraCustomerInfo, Appointment.appointmentCallNumber as AppointmentNumber ,SUM(maintItemFee) as TotalCost  from Private_Customer INNER JOIN Customer
	using(customerID) INNER JOIN Vehicle using(customerID) INNER JOIN Appointment using(VIN)
	INNER JOIN Maintenance_Visit_Order using(appointmentCallNumber) INNER JOIN Maintenance_Visit_Order_Line using(appointmentCallNumber)
	INNER JOIN Maintenance_Item using(maintItemID)
	GROUP BY Private_Customer.customerFirstName, Private_Customer.customerLastName, Appointment.appointmentCallNumber

UNION

SELECT Corporate_Customer.corporationName as MainCustomerInfo, 'N/A' as ExtraCustomerInfo, Appointment.appointmentCallNumber as AppointmentNumber ,SUM(maintItemFee) as TotalCost  from Corporate_Customer INNER JOIN Customer
	using(customerID) INNER JOIN Vehicle using(customerID) INNER JOIN Appointment using(VIN)
	INNER JOIN Maintenance_Visit_Order using(appointmentCallNumber) INNER JOIN Maintenance_Visit_Order_Line using(appointmentCallNumber)
	INNER JOIN Maintenance_Item using(maintItemID)
	GROUP BY Corporate_Customer.corporationName, 'N/A', Appointment.appointmentCallNumber
)t;


--#3
SELECT Customer, ExtraCustomerInfo, NetSpent from
(Select Private_Customer.customerFirstName as Customer, Private_Customer.customerLastName
as ExtraCustomerInfo,Sum(amountPaid)and Sum(maintItemFee) as NetSpent from Private_Customer
INNER JOIN Customer using(customerID)
Inner join Steady_Customer using(customerID)
Inner join Vehicle using(customerID)
INNER JOIN Appointment using(VIN)
INNER JOIN Registered_Customer using(customerID)
Inner join Monthly_Payment using(customerID)
Inner join Maintenance_Visit_Order using(appointmentCallNumber)
INNER JOIN Maintenance_Visit_Order_Line using(appointmentCallNumber)
INNER JOIN Maintenance_Item using(maintItemID)
UNION
SELECT Corporate_Customer.corporationName as Customer, 'N/A' as ExtraCustomerInfo,
Sum(amountPaid)and Sum(maintItemFee) as NetSpent from Corporate_Customer
Inner Join Customer using(customerID)
INNER JOIN Registered_Customer using(customerID)
Inner JOIn Monthly_Payment using(customerID)
Inner join Vehicle using(customerID)
INNER JOIN Appointment using(VIN)
Inner join Steady_Customer using(customerID)
Inner join Maintenance_Visit_Order using(appointmentCallNumber)
INNER JOIN Maintenance_Visit_Order_Line using(appointmentCallNumber)
INNER JOIN Maintenance_Item using(maintItemID)
)t;


--#4
 SELECT Employee.employeeFName, Employee.employeeLName from Employee
	Where Employee.employeeID in
	(SELECT Mechanic.mechanicID from Mechanic where mechanicID in
		(SELECT Mechanic_Proficiency.mechanicID from Mechanic_Proficiency
			Group by Mechanic_Proficiency.mechanicID
			HAVING COUNT(Mechanic_Proficiency.skillName)>=3));


--#6a
SELECT Maintenance_Package.maintPackageDescription, Maintenance_Package.maintPackageID, SUM(Maintenance_Item.maintItemFee) as TotalSummation from Maintenance_Package
INNER JOIN Maintenance_Item using(maintPackageID)
	group by Maintenance_Package.maintPackageDescription, Maintenance_Package.maintPackageID
order by Maintenance_Package.maintPackageID;

--#6b
SELECT Maintenance_Package.maintPackageID, Maintenance_Package.maintPackageDescription, Maintenance_Item.maintItemName, Maintenance_Item.maintItemFee from Maintenance_Package
	INNER JOIN Maintenance_Item using (maintPackageID);


--#7
SELECT Employee.employeeFName, Employee.employeeLName from Employee where Employee.employeeID in
(SELECT Mechanic.mechanicID from Mechanic where Mechanic.mechanicID in
(SELECT Mechanic_Proficiency.mechanicID FROM Mechanic_Proficiency INNER JOIN Maintenance_Visit_Order_Line using(mechanicID)
	INNER JOIN Maintenance_Item using(maintItemID)
	where Maintenance_Visit_Order_Line.skillName != Maintenance_Item.maintItemName));


--#8
SELECT Customer, ExtraCustomerInfo, Balance
	from(
    	SELECT Private_Customer.customerFirstName as Customer, Private_Customer.customerLastName as ExtraCustomerInfo, Steady_Customer.loyaltyPointBalance as Balance from Private_Customer
        	INNER JOIN Customer using(customerID) INNER JOIN Registered_Customer using(customerID)
        	INNER JOIN Steady_Customer using(customerID)
    
    	UNION

    	SELECT Corporate_Customer.corporationName as Customer, 'N/A' as ExtraCustomerInfo, Steady_Customer.loyaltyPointBalance as Balance from Corporate_Customer
        	INNER JOIN Customer using (customerID) INNER JOIN Registered_Customer using (customerID)
        	INNER JOIN Steady_Customer using(customerID)

    	)t
    	order by Balance DESC;


--#10
SELECT MainCustInfo, ExtraCustomerInfo, NetProfit-((SELECT annualUtilitiesRate from Shop_Financial_Record)/(SELECT COUNT(customerID)from Customer INNER JOIN Steady_Customer using(customerID) INNER JOIN Vehicle using(customerID) inner join Appointment using(VIN))) as NetProfit from
(SELECT Private_Customer.CUSTOMERFIRSTNAME as MainCustInfo, Private_Customer.CUSTOMERLASTNAME as ExtraCustomerInfo, SUM(maintItemFee) as NetProfit from Private_Customer INNER JOIN Customer using(customerID)
	INNER JOIN Registered_Customer using(customerID) INNER JOIN Steady_Customer using(customerID)
	INNER JOIN Vehicle using(customerID) INNER JOIN Appointment using(VIN) INNER JOIN Maintenance_Visit_Order using(appointmentCallNumber)
	INNER JOIN Maintenance_Visit_Order_Line using(appointmentCallNumber) INNER JOIN Maintenance_Item using(maintItemID)
	GROUP BY Private_Customer.customerFirstName, Private_Customer.customerLastName

UNION

SELECT Corporate_Customer.corporationName as MainCustInfo,'n/a' as ExtraCustomerInfo, SUM(maintItemFee) as NetProfit from Corporate_Customer INNER JOIN Customer using(customerID)
	INNER JOIN Registered_Customer using(customerID) INNER JOIN Steady_Customer using(customerID)
	INNER JOIN Vehicle using(customerID) INNER JOIN Appointment using(VIN) INNER JOIN Maintenance_Visit_Order using(appointmentCallNumber)
	INNER JOIN Maintenance_Visit_Order_Line using(appointmentCallNumber) INNER JOIN Maintenance_Item using(maintItemID)
	GROUP BY Corporate_Customer.corporationName, 'n/a'
)t

order by NetProfit desc;


--#11
SELECT Customer, ExtraCustomerInfo, PYear, AmountPaid from
(SELECT Private_Customer.customerFirstName as Customer, Private_Customer.customerLastName as ExtraCustomerInfo, Monthly_Payment.paymentYear as PYear, SUM(Monthly_Payment.amountPaid) as AmountPaid from Private_Customer
 	INNER JOIN Customer using(customerID) INNER JOIN Registered_Customer using(customerID) INNER JOIN Premier_Customer using(customerID)
 	INNER JOIN Monthly_Payment using(customerID) where Monthly_Payment.paymentYear = YEAR(NOW())-1 group by Private_Customer.customerFirstName, Private_Customer.customerLastName, Monthly_Payment.paymentYear
    
UNION

SELECT Corporate_Customer.corporationName as Customer, 'N/A' as ExtraCustomerInfo, Monthly_Payment.paymentYear as PYear, SUM(Monthly_Payment.amountPaid) as AmountPaid from Corporate_Customer
 	INNER JOIN Customer using(customerID) INNER JOIN Registered_Customer using(customerID) INNER JOIN Premier_Customer using(customerID)
 	INNER JOIN Monthly_Payment using(customerID) where Monthly_Payment.paymentYear = YEAR(NOW())-1 group by Corporate_Customer.corporationName, 'N/A', Monthly_Payment.paymentYear
    
)t
order by AmountPaid
LIMIT 3;


--#12
SELECT modelName, makeName, modelYear, AVG(Visits_Per_Vehicle) AS Average_Visits
FROM
( 
    SELECT vm.modelName, vm.makeName, vm.modelYear, vm.modelID, COUNT(a.appointmentCallNumber) AS Visits_Per_Vehicle
    FROM Vehicle_Model AS vm
    INNER JOIN Vehicle AS v ON vm.modelID = v.modelID
    INNER JOIN Appointment AS a ON v.VIN = a.VIN
    GROUP BY v.VIN
) as T
GROUP BY modelID
ORDER BY Average_Visits DESC
LIMIT 5
;

--#13
(SELECT DISTINCT Employee.employeeFName, Employee.employeeLName, Mentorship.mentorID, Mentorship.SKILLNAME from Employee INNER JOIN  Mechanic on Employee.employeeID = Mechanic.mechanicID INNER JOIN Mechanic_Proficiency using(mechanicID) INNER JOIN Mentorship on Mechanic_Proficiency.mechanicID = Mentorship.mentorID WHERE Mechanic_Proficiency.mechanicID IN
	(select Mentorship.mentorID from Mentorship GROUP BY Mentorship.mentorID
     	having count(Mentorship.menteeID) = (select max(menteeCounter) from (select mentorID, count(menteeID) as menteeCounter from Mentorship group by mentorID)t1)));


--#14
 SELECT skillName, COUNT(Mechanic_Proficiency.mechanicID) as MechanicCount from Mechanic_Proficiency
	group by skillName
	order by MechanicCount ASC
	LIMIT 3;


--#15
SELECT employeeFName, employeeLName FROM Employee
WHERE employeeID IN
(
SELECT mechanicID FROM Mechanic
INNER JOIN Service_Technician ON Mechanic.mechanicID = Service_Technician.serviceTechID
);


--#16a
SELECT Employee.employeeFName, Employee.employeeLName from Employee where Employee.employeeID in
(SELECT mechanicID
FROM Mechanic
WHERE YEAR(NOW()) - YEAR(dateOfBirth) >= 65);


--#16b
SELECT managerID, managerLName, managerFName
FROM Manager;


--#16c
SELECT MainCustomerInfo, ExtraCustomerInfo, PhoneType from
(SELECT Private_Customer.customerFirstName as MainCustomerInfo, Private_Customer.customerLastName as ExtraCustomerInfo, Phone_Number.phoneType as PhoneType from Private_Customer
    INNER JOIN Customer using(customerID) INNER JOIN Phone_Number ON Private_Customer.CUSTOMERID = Phone_Number.OWNERID

UNION
    
SELECT Corporate_Customer.corporationName as MainCustomerInfo, 'N/A' as ExtraCustomerInfo, Phone_Number.phoneType as PhoneType from Corporate_Customer
     INNER JOIN Customer using(customerID) INNER JOIN Phone_Number ON Corporate_Customer.CUSTOMERID = Phone_Number.OWNERID
) t1
;