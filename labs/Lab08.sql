-- Diego Barreras
-- Brian Gonzalez

-- Lab 08: Constraints 

	ALTER TABLE SalesPeople ADD PRIMARY KEY (SalesID);

	DROP TABLE IF EXISTS Contracts;

	Create Table Contracts (
		ContractID Int Not Null,
		ArtistID Int Not Null,
		ContractType VarChar(10) Not Null,
		ContractDate DateTime Not Null,
		ExpirationDate DateTime Not Null,
		ContractPrice Int Not Null,
		SalesID Smallint Null);
      
-- Q1: ContractID is the primary key and the default value of SalesID is 1.

	ALTER TABLE Contracts 
	ADD PRIMARY KEY (ContractID),
	ALTER SalesID
	SET DEFAULT 1;

    
-- Q2: Create a foreign key constraint to enforce that SalesID of the Contracts table refers to SalesID of the SalesPeople table.

	ALTER TABLE Contracts
	ADD CONSTRAINT FK_SalesPeople_Contracts
	FOREIGN KEY (SalesID)
	REFERENCES SalesPeople(SalesID);

-- Q3: Create a constraint so that the combination of ContractDate and ExpirationDate is unique.

	ALTER TABLE Contracts
	ADD CONSTRAINT un_contract_expiration_date
	UNIQUE (ContractDate, ExpirationDate);

-- Q4: Drop the primary key created in Q1.

	ALTER TABLE Contracts
	DROP PRIMARY KEY;
    