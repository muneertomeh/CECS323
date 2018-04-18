INSERT INTO Customer (customerID, customerEmail) 
    VALUES
    (1, 'bob@mail.com'),
    (2, 'jim@net.com'),
    (3, 'dj23@gmail.com'),
    (4, 'marin45@tele.com'),
    (5, 'shaq23@mail.com'),
    (6, 'anonymous@gmail.com'),
    (7, 'santaclaus@yahoo.com'),
    (8, 'housemd@hotmail.com'),
    (9, 'stevejmt@hotmail.com'),
    (10, 'tkirkman@gmail.com'),
    (11, 'sheldcoop@yahoo.com'),
    (12, 'idkwhoseemail@hotmail.com');


INSERT INTO Phone_Type (phoneType)
    VALUES
    ('Fax'),
    ('Home Phone'),
    ('Work Phone'),
    ('Mobile Phone');

INSERT INTO Phone_Number (ownerID, phoneType, phoneNumber)
    VALUES
    (1, 'Home Phone', '234-333-8008'),
    (1, 'Mobile Phone', '721-421-9001'),
    (2, 'Work Phone', '481-516-2342'),
    (3, 'Home Phone', '314-159-2653'),
    (4, 'Home Phone', '455-222-7676'),
    (5, 'Work Phone', '777-221-8822'),
    (6, 'Fax', '999-222-4545'),
    (7, 'Home Phone', '111-222-3333'),
    (8, 'Mobile Phone', '777-323-9999'),
    (9, 'Fax', '999-888-8329'),
    (10, 'Work Phone', '111-333-2222'),
    (11, 'Work Phone', '777-111-2222'),
    (12, 'Home Phone', '999-888-7777');


INSERT INTO State (stateCode, stateName)
    VALUES
    ('AL', 'Alabama'),
    ('AK', 'Alaska'),
    ('AZ', 'Arizona'),
    ('AR', 'Arkansas'),
    ('CA', 'California'),
    ('CO', 'Colorado'),
    ('CT', 'Connecticut'),
    ('DE', 'Delaware'),
    ('DC', 'District of Columbia'),
    ('FL', 'Florida'),
    ('GA', 'Georgia'),
    ('HI', 'Hawaii'),
    ('ID', 'Idaho'),
    ('IL', 'Illinois'),
    ('IN', 'Indiana'),
    ('IA', 'Iowa'),
    ('KS', 'Kansas'),
    ('KY', 'Kentucky'),
    ('LA', 'Louisiana'),
    ('ME', 'Maine'),
    ('MD', 'Maryland'),
    ('MA', 'Massachusetts'),
    ('MI', 'Michigan'),
    ('MN', 'Minnesota'),
    ('MS', 'Mississippi'),
    ('MO', 'Missouri'),
    ('MT', 'Montana'),
    ('NE', 'Nebraska'),
    ('NV', 'Nevada'),
    ('NH', 'New Hampshire'),
    ('NJ', 'New Jersey'),
    ('NM', 'New Mexico'),
    ('NY', 'New York'),
    ('NC', 'North Carolina'),
    ('ND', 'North Dakota'),
    ('OH', 'Ohio'),
    ('OK', 'Oklahoma'),
    ('OR', 'Oregon'),
    ('PA', 'Pennsylvania'),
    ('RI', 'Rhode Island'),
    ('SC', 'South Carolina'),
    ('SD', 'South Dakota'),
    ('TN', 'Tennessee'),
    ('TX', 'Texas'),
    ('UT', 'Utah'),
    ('VT', 'Vermont'),
    ('VA', 'Virginia'),
    ('WA', 'Washington'),
    ('WV', 'West Virginia'),
    ('WI', 'Wisconsin'),
    ('WY', 'Wyoming');    

INSERT INTO Address_Type (addressType, addressDescr)
    VALUES
    ('Billing', 'Address to receive credit card statements'),
    ('Mailing', 'Address to receive letters or packages'),
    ('Vehicle Pickup', 'Address to pickup certain items'),
    ('Vehicle Delivery', 'Address to dropoff certain items');


INSERT INTO Private_Customer (customerID, stateCode, customerFirstName, customerLastName, street, city, zipCode)
    VALUES
    (2, 'NM', 'Walter', 'White', '357 Lemon St', 'Albuquerque', '8701'),
    (4, 'CA', 'Shawn', 'Spencer', '24 Apple Dr', 'Santa Barbara', '93101'),
    (6, 'CA', 'Adrian', 'Monk', '2593 Pecan Ave','San Francisco', '94016'),
    (8, 'NJ', 'Gregory', 'House', '19046 Cherry St','Princeton', '08542'),
    (9, 'WA', 'Delsin', 'Rowe', '1457 Peanut Dr','Seattle', '98101'),
    (10, 'MD', 'Tom', 'Kirkman', '7863 Grape Ave','Washington D.C.','20005'),
    (11, 'CA', 'Sheldon', 'Cooper', '3628 Apricot Cir','Pasadena', '91125'),
    (12, 'NV', 'Johnny', 'Roberts', '47528 Banana Blvd','Henderson', '89012');


INSERT INTO Corporate_Customer (customerID, corporationName)
    VALUES
    (1, 'Hertz'),
    (3, 'Thrifty'),
    (5, 'Avis'),
    (7, 'Enterprise');


INSERT INTO Address (customerID, addressType, stateCode, street, city, zipCode)
    VALUES
    (1,'Billing', 'CA', '37 Avocado Ave','Buena Park', '90620'),
    (1, 'Mailing', 'CA', '37458 Tangerine St' ,'Oxnard', '98023'),
    (3, 'Vehicle Pickup', 'CA', '8 Fig St','Temecula', '92590'),
    (3, 'Mailing', 'CA', '2974 Guava Blvd','Long Beach', '90723'),
    (5, 'Billing', 'UT', '87590 Melon St','St. George', '90343'),
    (5, 'Vehicle Delivery', 'CA', '22 Kiwi St','Fountain Valley', '98633'),
    (5, 'Vehicle Pickup', 'CA', '748 Mango Cir','Huntington Beach', '94523'),
    (5, 'Mailing', 'CA', '4783 Orange Ave','Oceanside', '92501'),
    (7, 'Mailing', 'OR', ' 2398 Lemon St','Portland', '98301');


INSERT INTO Registered_Customer (customerID, registrationDate)
    VALUES
    (1, '2017-11-24'),
    (2, '2016-08-14'),
    (3, '2016-10-06'),
    (4, '2015-07-04'),
    (5, '2017-01-12'),
    (6, '2017-03-10'),
    (7, '2014-12-25'),
    (8, '2012-04-28');


INSERT INTO Status (status)
    VALUES
    ('Dead Prospect'),
    ('Not Yet Contacted'),
    ('Contact In Progress'),
    ('Converted');


INSERT INTO Prospective_Customer (customerID, referralID, status, referralDate)
    VALUES
    (9, 3, 'Dead Prospect', '2015-10-03'),
    (10, 5, 'Contact In Progress', '2016-10-28'),
    (11, 7, 'Not Yet Contacted', '2017-03-15'),
    (12, 8, 'Not Yet Contacted', '2016-02-12');


INSERT INTO Contact_Method (contactMethod)
    VALUES
    ('Email'),
    ('Phone Call');

INSERT INTO Special_Offer_Contact (customerID, contactMethod, contactDate, quote)
    VALUES
    (11, 'Email', '2016-11-05', 'Fantastic rewards for every customer'),
    (11, 'Phone Call', '2016-11-21', 'Come down to the shop for great service!'),
    (10, 'Email', '2015-10-04', 'Great service at great prices!'),
    (10, 'Email', '2015-11-01', 'Become a customer today!'),
    (10, 'Phone Call', '2015-12-25', 'We wish you a Merry Christmas!');  

INSERT INTO Premier_Customer (customerID, hypothSteadyFee, rewardStatus)
    VALUES
    (6, 100.00, false),
    (7, 150.00, false),
    (8, 200.00, false);


INSERT INTO Steady_Customer (customerID, emailNotification, rewardStatus, loyaltyPointBalance)
    VALUES
    (1, 'Appointment Nearing', true, 900),
    (2, 'Appointment Nearing', true, 756),
    (3, 'Appointment in 2 months', false, 1890),
    (4, 'Appointment in 1 month', false, 450),
    (5, 'Appointment Nearing', true, 100);


INSERT INTO Vehicle_Model (modelID, makeName, modelName, modelYear)
    VALUES
    (1001, 'Ford', 'Mustang', 2012),
    (1002, 'Koenigsegg', 'Agera', 2011),
    (1003, 'DeLorean', 'DMC-12', 1981),
    (1004, 'Aston Martin', 'Vanquish', 2012),
    (1005, 'Lamborghini', 'Aventador', 2017),
    (1006, 'Ferrari', 'LaFerrari', 2015),
    (1007, 'Bugatti', 'Chiron', 2016),
    (1008, 'Nissan', 'GT-R', 2017),
    (1009, 'Mazda', 'MX-5', 2016),
    (1010, 'McLaren', 'P1', 2015);


INSERT INTO Vehicle (customerID, VIN, modelID, licensePlateNo, mileageAtLastAppointment, estimatedYearlyMileage, accidentCount)
    VALUES
    (6, '1FT7W2B61BEA08706', 1001, '420BLZIT', 60000, 7000, 3),
    (1, '1HSHEAHNXTH421568', 1008, '5G2K0LL', 90000, 23323, 0),
    (1, '5YJSA1DP7CFS22754', 1007, '4GRTP23', 209344, 45000, 1),
    (2, '4AJSA7JJJUUU33677', 1002, '3HTTP42', 70000, 8000, 0),
    (3, '7HELLOKITTYS77322', 1003, '6MOON56', 65000, 5000, 1),
    (3, '6ILUVRACHEL188999', 1004, '1LUCK27', 40000, 7000, 2),
    (4, '8MOONLIGHTS555222', 1004, '2FOOD78', 50000, 6000, 1),
    (6, '1FT7W2B6345608706', 1010, '430BLZIT', 60000, 7000, 3),
    (8, '2FR490344434KDSKL' , 1008, '440BLZIT', 70000, 8000, 0),
    (5, '4JSIDOSLCDD444999', 1009, '2MEAT53', 80000, 10000, 2),
    (7,  'K934343492DF324FK', 1005, '9K23S87', 90000,1000, 5),
    (8, '1JSJDISI82222333J', 1006, '5KDSS023', 85000, 8300, 2);



INSERT INTO Maintenance_Package (modelID, maintPackageID, maintPackageDescription, recommendedMileage)
    VALUES
    (1001, 1, 'Ford Mustang', 60000),
    (1001, 3, 'Ford Mustang', 90000),
    (1002, 4, 'Koenigsegg Agera', 60000),
    (1003, 2, 'Delorean DMC-12', 100000),
    (1004, 5, 'Aston Martin Vanquish', 60000),
    (1005, 6, 'Lamborghini Aventador', 30000),
    (1006, 7, 'Ferrari LaFerrari', 90000),
    (1007, 8, 'Bugatti Chiron', 60000),
    (1008, 9, 'Nissan GT-R', 60000),
    (1009, 10,'Mazda MX-5', 90000),
    (1010, 11, 'McLaren P1', 60000),
    (1010, 12, 'McLaren P1', 90000);

INSERT INTO Maintenance_Item (maintPackageID, maintItemID, maintItemName, maintItemFee)
    VALUES
    (1, 1, 'Oil Change', 40.00),
    (1, 2, 'Coolant Replacement', 120.00),
    (1, 3, 'Spark Plug Replacement', 120.00), 
    (2, 4, 'Battery Replacement', 175.00),
    (2, 5, 'Tire Rotation', 40.00),
    (2, 6, 'A/C Compressor Rotation', 700.00),
    (3, 7, 'Fuel Injector Replacement', 300.00),
    (3, 8, 'Catalytic Converter Replacement', 800.00), 
    (3, 9, 'Water Pump Replacement', 700.00),
    (4, 10, 'Wiper Blades Replacement', 290.00),
    (4, 11, 'Brake Pad Replacement', 200.00),
    (4, 12, 'Brake Disc Replacement', 250.00),
    (5, 13, 'Brake Lights Replacement', 260.00),
    (5, 14, 'Ignition Tuneup', 260.00),
    (5, 15, 'Engine Air Filter Replacement', 60.00), 
    (6, 16, 'Power Steering Fluid Replacement', 120.00),
    (6, 17, 'Transmission Fluid Replacement', 130.00),
    (6, 18, 'Washer Fluid Replacement', 100.00),
    (7, 19, 'Timing Belt Check', 90.00),
    (7, 20, 'Headlight Assembly Check', 280.00),
    (7, 21, 'Signal Light Replacement', 320.00),
    (8, 22, 'Wheel Alignment Checkup', 60.00),
    (8, 23, 'Check Engine Light Diagnosis', 150.00),
    (8, 24, 'Emission Check', 20.00),  
    (9, 25, 'Mirror Replacement', 85.00),
    (9, 26, 'Transmission Replacement', 1000.00),
    (9, 27, 'Air Cabin Filter', 500.00),
    (10, 28, 'Muffler Replacement', 400.00),
    (10, 29, 'Fuel Pump Replacement', 700.00),
    (10, 30, 'Cooling Fan Replacement', 420.00),
    (11, 31, 'Engine Mount Replacement', 300.00),
    (11, 32, 'Hood Insulator', 200.00),
    (11, 33, 'Door Handle Replacement', 150.00),
    (12, 34, 'Radiator Hose Replacement', 650.00),
    (12, 35, 'Window Motor Replacement', 670.00),
    (12, 36, 'Transmission Mount Replacement', 700.00),
    (null, 37, 'Shock Absorber Replacement', 900.00),
    (null, 38, 'Carburetor Replacement', 200.00),
    (null, 39, 'Driveshaft Replacement', 500.00);

INSERT INTO Shop_Financial_Record (shopName, annualRentRate, annualUtilitiesRate) 
    VALUES
    ('Daveís Automotive', 25000.00, 2500.00);

INSERT INTO Month (month, monthName)
    VALUES
    (1, 'January'),
    (2, 'February'),
    (3, 'March'),
    (4, 'April'),
    (5, 'May'),
    (6, 'June'),
    (7, 'July'),
    (8, 'August'),
    (9, 'September'),
    (10, 'October'),
    (11, 'November'),
    (12, 'December');

INSERT INTO Monthly_Payment (customerID, paymentMonth, paymentYear, amountPaid, VIN, shopName)
    VALUES
    (6, 12, 2017, 100, '1FT7W2B61BEA08706', 'Daveís Automotive'),
    (6, 11, 2017, 100, '1FT7W2B6345608706', 'Daveís Automotive'),
    (6, 10, 2017, 100, '1FT7W2B61BEA08706', 'Daveís Automotive'),  
    (6, 9, 2017, 100, '1FT7W2B61BEA08706', 'Daveís Automotive'),  
    (6, 8, 2017, 100, '1FT7W2B61BEA08706', 'Daveís Automotive'),  
    (6, 7, 2017, 100, '1FT7W2B61BEA08706', 'Daveís Automotive'),  
    (6, 6, 2017, 100, '1FT7W2B61BEA08706', 'Daveís Automotive'),  
    (6, 5, 2017, 100, '1FT7W2B61BEA08706', 'Daveís Automotive'),  
    (6, 4, 2017, 100, '1FT7W2B61BEA08706', 'Daveís Automotive'),  
    (8, 12, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 11, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 10, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 9, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 8, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 7, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 6, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 5, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 4, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 3, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 2, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 1, 2017, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 12, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 11, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 10, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 9, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 8, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 7, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 6, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 5, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 4, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 3, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 2, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 1, 2016, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 12, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 11, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 10, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 9, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 8, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 7, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 6, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 5, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 4, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 3, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 2, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 1, 2015, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 12, 2014, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 11, 2014, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 10, 2014, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 9, 2014, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 8, 2014, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 7, 2014, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 6, 2014, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 5, 2014, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (8, 4, 2014, 150 , '2FR490344434KDSKL', 'Daveís Automotive'),
    (7, 12, 2017, 300,  'K934343492DF324FK', 'Daveís Automotive'),
    (7, 11, 2017, 250,  'K934343492DF324FK', 'Daveís Automotive'),
    (7, 10, 2017, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 9, 2017, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 8, 2017, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 7, 2017, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 6, 2017, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 5, 2017, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 4, 2017, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 3, 2017, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 2, 2017, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 1, 2017, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 12, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 11, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 10, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 9, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 8, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 7, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 6, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 5, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 4, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 3, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 2, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 1, 2016, 150 , 'K934343492DF324FK', 'Daveís Automotive'),
    (7, 12, 2015, 150 , 'K934343492DF324FK', 'Daveís Automotive');

INSERT INTO Appointment (appointmentCallNumber, VIN, appointmentDate, appointmentTime)
    VALUES
    (1, '1HSHEAHNXTH421568', '2017-12-27', '10:30'),
    (2, '1HSHEAHNXTH421568', '2018-02-01', '10:30'),
    (3, '5YJSA1DP7CFS22754', '2015-08-27', '11:30'),
    (4, '2FR490344434KDSKL', '2017-02-01', '12:30'),
    (5, '1HSHEAHNXTH421568', '2018-02-02', '10:30'),
    (6, '1HSHEAHNXTH421568', '2017-02-02', '10:30'),
    (7, '8MOONLIGHTS555222', '2016-08-09', '9:30'),
    (8, '8MOONLIGHTS555222', '2016-12-29', '7:30'),
    (9, '6ILUVRACHEL188999', '2015-11-09', '1:30'),
    (10, '6ILUVRACHEL188999', '2016-11-09', '12:30'),
    (11, '1HSHEAHNXTH421568', '2014-04-05', '2:30'),
    (12, '4AJSA7JJJUUU33677', '2016-03-04', '1:30'),
    (13, '7HELLOKITTYS77322',  '2016-04-17',  '4:00'),
    (14, '1FT7W2B61BEA08706', '2017-06-29', '3:30'),
    (15, '2FR490344434KDSKL', '2016-08-23', '3:00'),
    (16, '2FR490344434KDSKL', '2015-11-03', '2:30');

INSERT INTO Manager (shopName, managerID, managerFName, managerLName, salary) 
    VALUES
    ('Daveís Automotive', 1, 'Joe', 'Doe', 50000.00);

INSERT INTO Employee (shopName, employeeID, employeeFName, employeeLName, salary, managerID)
    VALUES
    ('Daveís Automotive', 1, 'Muneer', 'Tomeh', 30000.00, 1),
    ('Daveís Automotive', 2, 'Joe', 'West', 34444.00, 1),
    ('Daveís Automotive', 3, 'Matthew', 'Robinson', 25000.00, 1),
    ('Daveís Automotive', 4, 'Barry', 'Allen', 59009.00, 1),
    ('Daveís Automotive', 5, 'Oliver', 'Queen', 69000.00, 1),
    ('Daveís Automotive', 6, 'Bruce', 'Wayne', 60000.00, 1),
    ('Daveís Automotive', 7, 'Clark', 'Kent', 56293.00, 1),
    ('Daveís Automotive', 8, 'Diana', 'Prince', 32444.00, 1),
    ('Daveís Automotive', 9, 'Hal', 'Jordan', 43209.00, 1),
    ('Daveís Automotive', 10, 'Arthur', 'Curry', 46231.00, 1),
    ('Daveís Automotive', 11, 'Tony', 'Stark', 34232.00, 1),
    ('Daveís Automotive', 12, 'Steve', 'Rogers', 58231.00, 1),
    ('Daveís Automotive', 13, 'Bucky', 'Barnes', 32331.00, 1),
    ('Daveís Automotive', 14, 'Peter', 'Parker', 23998.00, 1),
    ('Daveís Automotive', 15, 'Bruce', 'Banner', 45123.00, 1);

INSERT INTO Employee_Evaluations ( managerID, employeeID, reviewDate, reviewPerformance)
    VALUES
    (1,1, '2015-12-25', 'Excellent'),
    (1,1, '2014-12-28', 'Outstanding'),
    (1,2, '2013-12-28', 'Excellent'),
    (1,2, '2016-12-29', 'Needs Improvement'),
    (1,4, '2012-12-29', 'Average'),
    (1,5, '2014-12-27', 'Needs improvement'),
    (1,8, '2014-12-27', 'Terrific'),
    (1,8, '2012-12-27', 'Satisfactory'),
    (1,10,'2015-12-25', 'Excellent'),
    (1,12,'2015-12-25', 'Needs improvement'),
    (1,13, '2013-12-28', 'Outstanding');
	
INSERT INTO Mechanic (mechanicID, dateOfBirth)
    VALUES
    (1, '1994-09-09'),
    (3, '1989-10-29'),
    (5, '1952-01-07'),
    (7, '1985-06-14'),
    (9, '1990-03-22'),
    (11, '1999-12-18'),
    (13, '1994-07-17'),
    (15, '1997-08-15');

INSERT INTO Skill (skillName, skillDescr)
    VALUES
    ('Oil Change', 'Removes dirty oil and replaces it with clean oil'),
    ('Tire Change', 'Replace old tires with new tires'),
    ('Brake Check', 'Inspect and check the overall status of car brakes'),
    ('Exhaust Check', 'Inspect and check the overall status of the carís exhaust'),
    ('Air Filtration', 'Inspects and cleans the carís air filtration'),
    ('Engine Inspection', 'Checks the status of engine to determine if it needs serious repairs'),
    ('Battery Maintenance', 'Covers all maintenance services of car batteries'),
    ('Windshield Inspection', 'Checks if carís windshields are in excellent condition'),
    ('Fluid Change', 'Replace all vehicular fluids'),
    ('Electrical Repair', 'Replace all electrical components'),
    ('Structural Repair', 'Replace all physical parts'),
    ('Ignition', 'Inspects ignitions');

INSERT INTO Skill_Proficiency (skillProficiency)
    VALUES
    ('Average'),
    ('Good'),
    ('Excellent');

INSERT INTO Mechanic_Proficiency (mechanicID, skillName, skillProficiency)
    VALUES
    (1, 'Oil Change', 'Excellent'),
    (1, 'Battery Maintenance', 'Good'),
    (1, 'Exhaust Check', 'Excellent'),
    (3, 'Oil Change', 'Average'),
    (3, 'Battery Maintenance', 'Good'),
    (3, 'Ignition', 'Excellent'),
    (3, 'Exhaust Check', 'Excellent'),
    (5, 'Tire Change', 'Excellent'),
    (5, 'Brake Check', 'Good'),
    (7, 'Engine Inspection', 'Average'),
    (7, 'Fluid Change', 'Excellent'),
    (7, 'Structural Repair', 'Average'),
    (9, 'Oil Change', 'Excellent'),
    (9, 'Brake Check', 'Average'),
    (11, 'Air Filtration', 'Average'),
    (11, 'Electrical Repair', 'Excellent'),
    (13, 'Structural Repair', 'Good'),
    (13, 'Windshield Inspection', 'Excellent'),
    (15, 'Electrical Repair', 'Good'),
    (15, 'Fluid Change', 'Good'),
    (3, 'Air Filtration', 'Good');

INSERT INTO Mentorship (mentorID, skillName, menteeID, progressReport, startingDate, endingDate)
    VALUES
    (1, 'Oil Change', 3, 'On track', '2015-09-02', '2016-01-03'),
    (1, 'Oil Change', 5, 'On track', '2013-06-17', '2015-11-24'),
    (1, 'Exhaust Check', 13, 'On track', '2016-01-27', '2018-09-18'),
    (3, 'Air Filtration', 15, 'Complete', '2005-11-09', '2006-04-05'),
    (9, 'Brake Check', 7, 'On track', '2007-07-17', '2008-04-19'),
    (9, 'Brake Check', 1, 'On track', '2017-08-27', '2017-12-26'),
    (7, 'Engine Inspection', 3, 'Complete', '2012-02-12', '2012-07-06');
	
INSERT INTO Retirement_Plan_Type (retirementPlanType)
    VALUES
    ('401k'),
    ('IRA'),
    ('SEP IRA'),
    ('Roth IRA'),
    ('Simple IRA');

INSERT INTO Retirement_Plan (retirementPlanID, retirementPlanType, retirementCompensation)
    VALUES
    (1000, '401k', 10000.00),
    (1001, 'IRA', 20000.00),
    (1002, 'SEP IRA', 30000.00),
    (1003, 'Roth IRA', 40000.00),
    (1004, 'Simple IRA', 50000.00);

INSERT INTO Former_Mechanic (mechanicID, retirementPlanID)
    VALUES
    (5, 1000);

INSERT INTO Service_Technician (serviceTechID)
    VALUES
    (1),
    (2),
    (3),
    (4),
    (6),
    (7),
    (8),
    (10),
    (12),
    (14);

INSERT INTO Maintenance_Visit_Order (appointmentCallNumber, maintPackageID, shopName, estimatedTime, serviceTechID, loyaltyPointsUsed)
    VALUES
    (1, 9, 'Daveís Automotive', '30' ,2,true),
    (2, 9, 'Daveís Automotive', '45', 2, true),
    (3, 8, 'Daveís Automotive', '55', 4, true),
    (4, null, 'Daveís Automotive', '25', 6, false),
    (5, null, 'Daveís Automotive', '35', 8, true),
    (6, null, 'Daveís Automotive', '45', 6, true),
    (7, 5, 'Daveís Automotive', '25', 4, true),
    (8, null, 'Daveís Automotive', '36', 8, true),
    (9, null, 'Daveís Automotive', '40', 2, false),
    (10, null, 'Daveís Automotive', '40', 2, true),
    (11, 9, 'Daveís Automotive', '35', 4, true),
    (12, 4, 'Daveís Automotive', '56', 6, true),
    (13, 2, 'Daveís Automotive', '34', 8, true),
    (14, null, 'Daveís Automotive', '44', 2, false),
    (15, null, 'Daveís Automotive', '39', 2, false),
    (16, null, 'Daveís Automotive', '51', 4, false);


INSERT INTO Maintenance_Visit_Order_Line (appointmentCallNumber, maintItemID, mechanicID, skillName)
    VALUES
    (1,25, 1, 'Oil Change'),
    (1,26, 1, 'Exhaust Check'),
    (1, 27, 3, 'Air Filtration'),
    (2,25, 5, 'Tire Change'),
    (2, 26, 1, 'Exhaust Check'),
    (2, 27, 11, 'Air Filtration'),
    (3, 23, 1, 'Oil Change'),
    (3, 24, 7, 'Engine Inspection'),
    (3, 22, 3, 'Air Filtration'),
    (4, 27, 5, 'Tire Change'),
    (5, 27, 9, 'Oil Change'),
    (5, 26, 7, 'Engine Inspection'),
    (6, 26, 13, 'Windshield Inspection'),
    (6, 27, 13, 'Structural Repair '),
    (7, 13, 9 , 'Brake Check' ),
    (7, 14, 3, 'Ignition'),
    (7, 15, 7, 'Engine Inspection'),
    (8, 14, 3, 'Ignition'),
    (8, 13, 9, 'Brake Check'),
    (9, 14, 3, 'Ignition'),
    (9, 15, 7, 'Engine Inspection'),
    (10, 14, 3, 'Ignition'),
    (10, 15, 7, 'Engine Inspection'),
    (11, 25, 13, 'Structural Repair'),
    (11, 26, 7, 'Engine Inspection'),
    (11, 27, 11, 'Air Filtration'),
    (12, 10, 1, 'Battery Maintenance'),
    (12, 11, 5, 'Tire Change'),
    (12, 12, 11, 'Air Filtration'),
    (13, 4, 7, 'Engine Inspection'),
    (13, 5, 1, 'Battery Maintenance'),
    (13, 6, 11, 'Air Filtration'),
    (14, 3, 3, 'Ignition'),
    (14, 9, 15, 'Fluid Change'),
    (14, 11, 5, 'Brake Check'),
    (14, 27, 3, 'Air Filtration'),
    (15, 14, 3, 'Ignition'),
    (15, 29, 7, 'Engine Inspection'),
    (15, 34, 15, 'Fluid Change'),
    (16, 26, 7, 'Engine Inspection'),
    (16, 36, 7, 'Engine Inspection');