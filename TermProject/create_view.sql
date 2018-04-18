CREATE VIEW Customer_v AS
SELECT customer, extraCustomerInfo, customerType, yearsWithCustomer
FROM (
		SELECT priv_c.customerFirstName AS Customer, priv_c.customerLastName AS ExtraCustomerInfo, 'Prospective Customer' AS CustomerType, YEAR(NOW()) - YEAR(pros_c.referralDate) AS YearsWithCustomer
		FROM Private_Customer AS priv_c
		INNER JOIN Prospective_Customer AS pros_c ON priv_c.customerID = pros_c.customerID

		UNION

		SELECT priv_c.customerFirstName AS Customer, priv_c.customerLastName AS ExtraCustomerInfo, 'Premier Customer' AS CustomerType, YEAR(NOW()) - YEAR(reg_c.registrationDate) AS YearsWithCustomer
		FROM Private_Customer AS priv_c
		INNER JOIN Registered_Customer AS reg_c ON priv_c.customerID = reg_c.customerID
		INNER JOIN Premier_Customer AS prem_c ON reg_c.customerID = prem_c.customerID

		UNION

		SELECT priv_c.customerFirstName AS Customer, priv_c.customerLastName AS ExtraCustomerInfo, 'Steady Customer' AS CustomerType, YEAR(NOW()) - YEAR(reg_c.registrationDate) AS YearsWithCustomer
		FROM Private_Customer AS priv_c
		INNER JOIN Registered_Customer AS reg_c ON priv_c.customerID = reg_c.customerID
		INNER JOIN Steady_Customer AS ste_c ON reg_c.customerID = ste_c.customerID 

		UNION

		SELECT corp_c.corporationName AS Customer, 'N/A' AS ExtraCustomerInfo, 'Prospective Customer' AS CustomerType, YEAR(NOW()) - YEAR(pros_c.referralDate) AS YearsWithCustomer
		FROM Corporate_Customer AS corp_c
		INNER JOIN Prospective_Customer AS pros_c ON corp_c.customerID = pros_c.customerID

		UNION

		SELECT corp_c.corporationName AS Customer, 'N/A' AS ExtraCustomerInfo, 'Premier Customer' AS CustomerType, YEAR(NOW()) - YEAR(reg_c.registrationDate) AS YearsWithCustomer
		FROM Corporate_Customer AS corp_c
		INNER JOIN Registered_Customer AS reg_c ON corp_c.customerID = reg_c.customerID
		INNER JOIN Premier_Customer AS prem_c ON reg_c.customerID = prem_c.customerID

		UNION

		SELECT corp_c.corporationName AS Customer, 'N/A' AS ExtraCustomerInfo, 'Steady Customer' AS CustomerType, YEAR(NOW()) - YEAR(reg_c.registrationDate) AS YearsWithCustomer
		FROM Corporate_Customer AS corp_c
		INNER JOIN Registered_Customer AS reg_c ON corp_c.customerID = reg_c.customerID
		INNER JOIN Steady_Customer AS ste_c ON reg_c.customerID = ste_c.customerID
	) AS T
;

CREATE VIEW Customer_addresses_v AS
SELECT customer, extraCustomerInfo, customerType, addressType, street, city, zipCode, stateCode
FROM (
		SELECT priv_c.customerFirstName AS customer, priv_c.customerLastName AS extraCustomerInfo, 'Private Customer' AS CustomerType,  'Residential' AS addressType, priv_c.street AS street,  priv_c.city AS city, priv_c.zipCode AS zipCode, priv_c.stateCode AS stateCode
		FROM Private_Customer AS priv_c

		UNION

		SELECT corp_c.corporationName AS customer, 'N/A' AS extraCustomerInfo, 'Corporate Customer' AS CustomerType, a.addressType AS AddressType, a.street AS street, a.city AS city, a.zipCode AS zipCode, a.stateCode AS stateCode
		FROM Corporate_Customer AS corp_c
		INNER JOIN Address AS a ON corp_c.customerID = a.customerID
	) AS T
;

CREATE VIEW Mechanic_mentor_v AS
SELECT mentor.employeeFName AS mentorFirstName, mentor.employeeLName AS mentorLastName, mentee.employeeFName AS menteeFirstName, mentee.employeeLName AS menteeLastName
FROM Employee AS mentor
INNER JOIN Mentorship AS m ON m.mentorID = mentor.employeeID
INNER JOIN Employee AS mentee ON m.menteeID = mentee.employeeID
ORDER BY mentor.employeeFName, mentor.employeeLName, mentee.employeeFName, mentee.employeeLName;

CREATE VIEW Premier_profits_v AS
SELECT T1.customer, T1.extraCustomerInfo, T1.year, T1.totalMonthlyPayments, T2.hypotheticalSpending
FROM (
SELECT priv_c.customerID AS customerID, priv_c.customerFirstName AS customer, priv_c.customerLastName AS extraCustomerInfo, mp.paymentYear AS year, SUM(mp.amountPaid) AS totalMonthlyPayments
FROM Private_Customer AS priv_c
INNER JOIN Premier_Customer AS prem_c ON priv_c.customerID = prem_c.customerID
LEFT OUTER JOIN Monthly_Payment AS mp ON prem_c.customerID = mp.customerID
GROUP BY priv_c.customerID, mp.paymentYear

UNION

SELECT corp_c.customerID AS customerID, corp_c.corporationName AS customer, 'N/A' AS extraCustomerInfo, mp.paymentYear AS year, SUM(mp.amountPaid) AS totalMonthlyPayments
FROM Corporate_Customer AS corp_c
INNER JOIN Premier_Customer AS prem_c ON corp_c.customerID = prem_c.customerID
LEFT OUTER JOIN Monthly_Payment AS mp ON prem_c.customerID = mp.customerID
GROUP BY corp_c.customerID, mp.paymentYear
) AS T1

INNER JOIN
(
SELECT priv_c.customerID AS customerID, priv_c.customerFirstName AS customer, priv_c.customerLastName AS extraCustomerInfo, year(a.appointmentDate) AS year, SUM(mi.maintItemFee) AS hypotheticalSpending
FROM Private_Customer AS priv_c
INNER JOIN Premier_Customer AS prem_c ON priv_c.customerID = prem_c.customerID
INNER JOIN Vehicle AS v ON priv_c.customerID = v.customerID
LEFT OUTER JOIN Appointment AS a ON v.VIN = a.VIN
INNER JOIN Maintenance_Visit_Order_Line AS mvol ON a.appointmentCallNumber = mvol.appointmentCallNumber
INNER JOIN Maintenance_Item AS mi ON mvol.maintItemID = mi.maintItemID
GROUP BY priv_c.customerID, year(a.appointmentDate)

UNION

SELECT corp_c.customerID AS customerID, corp_c.corporationName AS customer, 'N/A' AS extraCustomerInfo, year(a.appointmentDate) AS year, SUM(mi.maintItemFee) AS hypotheticalSpending
FROM Corporate_Customer AS corp_c
INNER JOIN Premier_Customer AS prem_c ON corp_c.customerID = prem_c.customerID
INNER JOIN Vehicle AS v ON prem_c.customerID = v.customerID
LEFT OUTER JOIN Appointment AS a ON v.VIN = a.VIN
INNER JOIN Maintenance_Visit_Order_Line AS mvol ON a.appointmentCallNumber = mvol.appointmentCallNumber
INNER JOIN Maintenance_Item AS mi ON mvol.maintItemID = mi.maintItemID
GROUP BY corp_c.customerID, year(a.appointmentDate)
) AS T2
ON (T1.customerID = T2.customerID AND T1.year=T2.year)
;

CREATE VIEW Prospective_resurrection_v AS
SELECT customer, extraCustomerInfo
FROM (
		SELECT priv_c.customerFirstName AS customer, priv_c.customerLastName AS extraCustomerInfo
		FROM Private_Customer AS priv_c
		INNER JOIN Prospective_Customer AS pros_c ON priv_c.customerID = pros_c.customerID
		INNER JOIN Special_Offer_Contact AS soc ON pros_c.customerID = soc.customerID
		HAVING (COUNT(soc.contactDate) > 2 AND YEAR(NOW()) - YEAR(MAX(soc.contactDate)) > 0)

		UNION

		SELECT corp_c.corporationName AS customer, 'N/A' AS ExtraCustomerInfo
		FROM Corporate_Customer AS corp_c
		INNER JOIN Prospective_Customer AS pros_c ON corp_c.customerID = pros_c.customerID
		INNER JOIN Special_Offer_Contact AS soc ON pros_c.customerID = soc.customerID
		HAVING (COUNT(soc.contactDate) > 2 AND YEAR(NOW()) - YEAR(MAX(soc.contactDate)) > 0)
	) AS T
;