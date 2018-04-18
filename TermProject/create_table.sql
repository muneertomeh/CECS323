CREATE TABLE Customer (
    customerID int NOT NULL,
    customerEmail varchar(255) NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (customerID),
    CONSTRAINT customer_uc UNIQUE (customerEmail)
);

CREATE TABLE Phone_Type (
    phoneType varchar(50) NOT NULL,
    CONSTRAINT phone_type_pk PRIMARY KEY (phoneType)
);

CREATE TABLE Phone_Number (
    ownerID int NOT NULL,
    phoneType varchar(50) NOT NULL,
    phoneNumber varchar(50) NOT NULL,
    CONSTRAINT phone_number_pk PRIMARY KEY (ownerID, phoneType),
    CONSTRAINT phone_number_fk1 FOREIGN KEY (ownerID) REFERENCES Customer (customerID),
    CONSTRAINT phone_number_fk2 FOREIGN KEY (phoneType) REFERENCES Phone_Type (phoneType)
);

CREATE TABLE State (
    stateCode varchar(2) NOT NULL,
    stateName varchar(50) NOT NULL,
    CONSTRAINT state_pk PRIMARY KEY (stateCode)
);

CREATE TABLE Address_Type (
    addressType varchar(50) NOT NULL,
    addressDescr varchar(255) NOT NULL,
    CONSTRAINT address_type_pk PRIMARY KEY (addressType)
);

CREATE TABLE Private_Customer (
    customerID int NOT NULL,
    stateCode varchar(2) NOT NULL,
    customerFirstName varchar(50) NOT NULL,
    customerLastName varchar(50) NOT NULL,
    street varchar(50) NOT NULL,
    city varchar(50) NOT NULL,
    zipCode varchar(15) NOT NULL,
    CONSTRAINT private_customer_pk PRIMARY KEY (customerID),
    CONSTRAINT private_customers_uc UNIQUE (customerFirstName, customerLastName, street),
    CONSTRAINT private_customer_fk1 FOREIGN KEY (customerID) REFERENCES Customer (customerID),
    CONSTRAINT private_cusotmer_fk2 FOREIGN KEY (stateCode) REFERENCES State (stateCode)
);

CREATE TABLE Corporate_Customer (
    customerID int NOT NULL,
    corporationName varchar(50) NOT NULL,
    CONSTRAINT corporate_customer_pk PRIMARY KEY (customerID),
    CONSTRAINT corporate_customer_fk1 FOREIGN KEY (customerID) REFERENCES Customer (customerID)
);

CREATE TABLE Address (
    customerID int NOT NULL,
    addressType varchar(50) NOT NULL,
    stateCode varchar(2) NOT NULL,
    street varchar(50) NOT NULL,
    city varchar(50) NOT NULL,
    zipCode varchar(50) NOT NULL,
    CONSTRAINT address_pk PRIMARY KEY (customerID, addressType, stateCode, street),
    CONSTRAINT address_fk1 FOREIGN KEY (customerID) REFERENCES Corporate_Customer (customerID),
    CONSTRAINT address_fk2 FOREIGN KEY (addressType) REFERENCES Address_Type (addressType),
    CONSTRAINT address_fk3 FOREIGN KEY (stateCode) REFERENCES State (stateCode)
);

CREATE TABLE Registered_Customer (
    customerID int NOT NULL,
    registrationDate date NOT NULL,
    CONSTRAINT registered_customer_pk PRIMARY KEY (customerID),
    CONSTRAINT registered_customer_fk1 FOREIGN KEY (customerID) REFERENCES Customer (customerID)
);

CREATE TABLE Status (
    status varchar(50) NOT NULL,
    CONSTRAINT status_pk PRIMARY KEY (status)
);

CREATE TABLE Prospective_Customer (
    customerID int NOT NULL,
    referralID int NOT NULL,
    status varchar(50) NOT NULL,
    referralDate date NOT NULL,
    CONSTRAINT prospective_customer_pk PRIMARY KEY (customerID),
    CONSTRAINT prospective_customer_fk1 FOREIGN KEY (customerID) REFERENCES Customer (customerID),
    CONSTRAINT prospective_customer_fk2 FOREIGN KEY (referralID) REFERENCES Registered_Customer (customerID),
    CONSTRAINT prospective_cusotmer_fk3 FOREIGN KEY (status) REFERENCES Status (status)
);

CREATE TABLE Contact_Method (
    contactMethod varchar(50) NOT NULL,
    CONSTRAINT contact_method_pk PRIMARY KEY (contactMethod)
);

CREATE TABLE Special_Offer_Contact (
    customerID int NOT NULL,
    contactMethod varchar(50) NOT NULL,
    contactDate date NOT NULL,
    quote varchar(50) NOT NULL,
    CONSTRAINT special_offer_contact_pk PRIMARY KEY (customerID, contactDate),
    CONSTRAINT special_offer_contact_fk1 FOREIGN KEY (customerID) REFERENCES Prospective_Customer (customerID),
    CONSTRAINT special_offer_contact_fk2 FOREIGN KEY (contactMethod) REFERENCES Contact_Method (contactMethod)
);

CREATE TABLE Premier_Customer (
    customerID int NOT NULL,
    hypothSteadyFee decimal(10,2) NOT NULL,
    rewardStatus boolean NOT NULL,
    CONSTRAINT premier_customer_pk PRIMARY KEY (customerID),
    CONSTRAINT premier_customer_fk1 FOREIGN KEY (customerID) REFERENCES Registered_Customer (customerID)
);

CREATE TABLE Steady_Customer (
    customerID int NOT NULL,
    emailNotification varchar(50) NOT NULL,
    rewardStatus boolean NOT NULL,
    loyaltyPointBalance int NOT NULL,
    CONSTRAINT steady_customer_pk PRIMARY KEY (customerID),
    CONSTRAINT steady_customer_fk1 FOREIGN KEY (customerID) REFERENCES Registered_Customer (customerID)
);

CREATE TABLE Vehicle_Model (
    modelID int NOT NULL,
    makeName varchar(50) NOT NULL,
    modelName varchar(50) NOT NULL,
    modelYear decimal(4,0) NOT NULL,
    CONSTRAINT vehicle_model_pk PRIMARY KEY (modelID),
    CONSTRAINT vehicle_model_uc UNIQUE (makeName, modelName, modelYear)
);

CREATE TABLE Vehicle (
    customerID int NOT NULL,
    VIN varchar(17) NOT NULL,
    modelID int NOT NULL,
    licensePlateNo varchar(10) NOT NULL,
    mileageAtLastAppointment int NOT NULL,
    estimatedYearlyMileage int NOT NULL,
    accidentCount int NOT NULL,
    CONSTRAINT vehicle_pk PRIMARY KEY (VIN),
    CONSTRAINT vehicle_uc UNIQUE (licensePlateNo),
    CONSTRAINT vehicle_fk1 FOREIGN KEY (customerID) REFERENCES Customer (customerID),
    CONSTRAINT vehicle_fk2 FOREIGN KEY (modelID) REFERENCES Vehicle_Model (modelID)
);

CREATE TABLE Maintenance_Package (
    modelID int NOT NULL,
    maintPackageID int NOT NULL,
    maintPackageDescription varchar(255) NOT NULL,
    recommendedMileage int NOT NULL,
    CONSTRAINT maintenance_package_pk PRIMARY KEY (maintPackageID),
    CONSTRAINT maintenance_package_uc UNIQUE (modelID, recommendedMileage),
    CONSTRAINT maintenance_package_fk1 FOREIGN KEY (modelID) REFERENCES Vehicle_Model (modelID)
);

CREATE TABLE Maintenance_Item (
    maintPackageID int,
    maintItemID int NOT NULL,
    maintItemName varchar(50) NOT NULL,
    maintItemFee decimal(10,2) NOT NULL,
    CONSTRAINT maintenance_item_pk PRIMARY KEY (maintItemID),
    CONSTRAINT maintenance_item_fk1 FOREIGN KEY (maintPackageID) REFERENCES Maintenance_Package (maintPackageID)
);

CREATE TABLE Shop_Financial_Record (
    shopName varchar(50) NOT NULL,
    annualRentRate decimal(10,2) NOT NULL,
    annualUtilitiesRate decimal(10,2) NOT NULL,
    CONSTRAINT shop_financial_record_pk PRIMARY KEY (shopName)
);

CREATE TABLE Month (
    month decimal(2,0) NOT NULL,
    monthName varchar(10) NOT NULL,
    CONSTRAINT month_pk PRIMARY KEY (month)
);

CREATE TABLE Monthly_Payment (
    customerID int NOT NULL,
    paymentMonth decimal(2,0) NOT NULL,
    paymentYear decimal(4,0) NOT NULL,
    amountPaid decimal(10,2) NOT NULL,
    VIN varchar(17) NOT NULL,
    shopName varchar(50) NOT NULL,
    CONSTRAINT monthly_payment_pk PRIMARY KEY (customerID, paymentMonth, paymentYear),
    CONSTRAINT monthly_payment_fk1 FOREIGN KEY (customerID) REFERENCES Premier_Customer (customerID),
    CONSTRAINT monthly_payment_fk2 FOREIGN KEY (paymentMonth) REFERENCES Month (month),
    CONSTRAINT monthly_payment_fk3 FOREIGN KEY (VIN) REFERENCES Vehicle (VIN),
    CONSTRAINT monthly_payment_fk4 FOREIGN KEY (shopName) REFERENCES Shop_Financial_Record (shopName)
);

CREATE TABLE Appointment (
    appointmentCallNumber int NOT NULL,
    VIN varchar(17) NOT NULL,
    appointmentDate date NOT NULL,
    appointmentTime time NOT NULL,
    CONSTRAINT appointment_pk PRIMARY KEY (appointmentCallNumber),
    CONSTRAINT appointment_uc UNIQUE (VIN, appointmentDate),
    CONSTRAINT appointment_fk1 FOREIGN KEY (VIN) REFERENCES Vehicle (VIN)
);

CREATE TABLE Manager (
    shopName varchar(50) NOT NULL,
    managerID int NOT NULL,
    managerFName varchar(50) NOT NULL,
    managerLName varchar(50) NOT NULL,
    salary decimal(10,2) NOT NULL,
    CONSTRAINT manager_pk PRIMARY KEY (managerID),
    CONSTRAINT manager_uc UNIQUE (managerFName, managerLName),
    CONSTRAINT manager_fk1 FOREIGN KEY (shopName) REFERENCES Shop_Financial_Record (shopName)
);

CREATE TABLE Employee (
    shopName varchar(50) NOT NULL,
    employeeID int NOT NULL,
    employeeFName varchar(50) NOT NULL,
    employeeLName varchar(50) NOT NULL,
    salary decimal(10,2) NOT NULL,
    managerID int NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY (employeeID),
    CONSTRAINT employee_uc UNIQUE (employeeFName, employeeLName),
    CONSTRAINT employee_fk1 FOREIGN KEY (shopName) REFERENCES Shop_Financial_Record (shopName),
    CONSTRAINT employee_fk2 FOREIGN KEY (managerID) REFERENCES Manager (managerID)
);

CREATE TABLE Employee_Evaluations (
    managerID int NOT NULL,
    employeeID int NOT NULL,
    reviewDate date NOT NULL,
    reviewPerformance varchar(255) NOT NULL,
    CONSTRAINT employee_evaluations_pk PRIMARY KEY (managerID, employeeID, reviewDate),
    CONSTRAINT employee_evaluations_fk1 FOREIGN KEY (managerID) REFERENCES Manager (managerID),
    CONSTRAINT employee_evaluations_fk2 FOREIGN KEY (employeeID) REFERENCES Employee (employeeID)
);

CREATE TABLE Mechanic (
    mechanicID int NOT NULL,
    dateOfBirth date NOT NULL,
    CONSTRAINT mechanic_pk PRIMARY KEY (mechanicID),
    CONSTRAINT mechanic_fk1 FOREIGN KEY (mechanicID) REFERENCES Employee (employeeID)
);

CREATE TABLE Skill (
    skillName varchar(50) NOT NULL,
    skillDescr varchar(255) NOT NULL,
    CONSTRAINT skill_pk PRIMARY KEY (skillName)
);

CREATE TABLE Skill_Proficiency (
    skillProficiency varchar(50) NOT NULL,
    CONSTRAINT skill_proficiency_pk PRIMARY KEY (skillProficiency)
);

CREATE TABLE Mechanic_Proficiency (
    mechanicID int NOT NULL,
    skillName varchar(50) NOT NULL,
    skillProficiency varchar(50) NOT NULL,
    CONSTRAINT mechanic_proficiency_pk PRIMARY KEY (mechanicID, skillName),
    CONSTRAINT mechanic_proficiency_fk1 FOREIGN KEY (mechanicID) REFERENCES Mechanic (mechanicID),
    CONSTRAINT mechanic_proficiency_fk2 FOREIGN KEY (skillName) REFERENCES Skill (skillName),
    CONSTRAINT mechanic_proficiency_fk3 FOREIGN KEY (skillProficiency) REFERENCES Skill_Proficiency (skillProficiency)
);

CREATE TABLE Mentorship (
    mentorID int NOT NULL,
    skillName varchar(50) NOT NULL,
    menteeID int NOT NULL,
    progressReport varchar(255) NOT NULL,
    startingDate date NOT NULL,
    endingDate date NOT NULL,
    CONSTRAINT mentorship_pk PRIMARY KEY (mentorID, skillName, menteeID, startingDate),
    CONSTRAINT mentorship_fk1 FOREIGN KEY (mentorID, skillName) REFERENCES Mechanic_Proficiency (mechanicID, skillName),
    CONSTRAINT mentorship_fk2 FOREIGN KEY (menteeID) REFERENCES Mechanic (mechanicID)
);

CREATE TABLE Retirement_Plan_Type (
    retirementPlanType varchar(50) NOT NULL,
    CONSTRAINT retirement_plan_type_pk PRIMARY KEY (retirementPlanType)
);

CREATE TABLE Retirement_Plan (
    retirementPlanID int NOT NULL,
    retirementPlanType varchar(50) NOT NULL,
    retirementCompensation decimal(10,2) NOT NULL,
    CONSTRAINT retirement_plan_pk PRIMARY KEY (retirementPlanID),
    CONSTRAINT retirement_plan_fk1 FOREIGN KEY (retirementPlanType) REFERENCES Retirement_Plan_Type (retirementPlanType)
);

CREATE TABLE Former_Mechanic (
    mechanicID int NOT NULL,
    retirementPlanID int,
    CONSTRAINT former_mechanic_pk PRIMARY KEY (mechanicID),
    CONSTRAINT former_mechanic_fk1 FOREIGN KEY (mechanicID) REFERENCES Mechanic (mechanicID),
    CONSTRAINT former_mechanic_fk2 FOREIGN KEY (retirementPlanID) REFERENCES Retirement_Plan (retirementPlanID)
);

CREATE TABLE Service_Technician (
    serviceTechID int NOT NULL,
    CONSTRAINT service_technician_pk PRIMARY KEY(serviceTechID),
    CONSTRAINT service_technician_fk1 FOREIGN KEY(serviceTechID) REFERENCES Employee(employeeID)
);

CREATE TABLE Maintenance_Visit_Order (
    appointmentCallNumber int NOT NULL,
    maintPackageID int,
    shopName varchar(50) NOT NULL,
    estimatedTime varchar(50) NOT NULL,
    serviceTechID int NOT NULL,
    loyaltyPointsUsed boolean NOT NULL,
    CONSTRAINT maintenance_visit_order_pk PRIMARY KEY (appointmentCallNumber),
    CONSTRAINT maintenance_visit_order_fk1 FOREIGN KEY (appointmentCallNumber) REFERENCES Appointment (appointmentCallNumber),
    CONSTRAINT maintenance_visit_order_fk2 FOREIGN KEY (maintPackageID) REFERENCES Maintenance_Package (maintPackageID),
    CONSTRAINT maintenance_visit_order_fk3 FOREIGN KEY (shopName) REFERENCES Shop_Financial_Record (shopName),
    CONSTRAINT maintenance_visit_order_fk4 FOREIGN KEY (serviceTechID) REFERENCES Service_Technician (serviceTechID)
);

CREATE TABLE Maintenance_Visit_Order_Line (
    appointmentCallNumber int NOT NULL,
    maintItemID int NOT NULL,
    mechanicID int NOT NULL,
    skillName varchar(50) NOT NULL,
    CONSTRAINT maintenance_visit_order_line_pk PRIMARY KEY (appointmentCallNumber, maintItemID),
    CONSTRAINT maintenance_visit_order_line_fk1 FOREIGN KEY (appointmentCallNumber) REFERENCES Maintenance_Visit_Order (appointmentCallNumber),
    CONSTRAINT maintenance_visit_order_line_fk2 FOREIGN KEY (maintItemID) REFERENCES Maintenance_Item (maintItemID),
    CONSTRAINT maintenance_visit_order_line_fk3 FOREIGN KEY (mechanicID, skillName) REFERENCES Mechanic_Proficiency (mechanicID, skillName)
);