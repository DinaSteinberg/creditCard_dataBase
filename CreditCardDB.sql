use master
go 

if exists (select *
             from sys.databases
			 where name = 'CreditCard')
   begin
      drop database CreditCard
   end
create database CreditCard

use CreditCard
go 

create table CreditCardType(
	TypeID int identity (1,1) not null,
	[Type] varchar(20) not null, 
	constraint [PK_Type] primary key (TypeID),
	constraint [CCType_Check] check ([Type] in ('VISA', 'MASTERCARD', 'AMEX', 'DISCOVER'))
	constraint [CCType_Unique] unique ([Type])
)

create table Status(
	StatusID int identity (1,1) not null,
	[Status] varchar(20) not null,			
	constraint [PK_Status] primary key (StatusID),
	constraint [Status_Check] check ([Status] in ('Active', 'Cancelled', 'Lost'))
	constraint [Status_Unique] unique ([Status])
)

create table CreditCard(
	CreditCardNum varchar(16) not null,   
	[Type] int not null,
	Company varchar(45) not null,
	IssueDate date not null,
	ExpirationDate date not null,
	CurrentBalance decimal(10,2) not null default (0),
	[Status] int not null,
	CreditLimit decimal (10,2) not null,
	AvailableCredit as CreditLimit-CurrentBalance,
	constraint [PK_CreditCard] primary key (CreditCardNum),
	constraint [IssueDate_Check] check (IssueDate < ExpirationDate and IssueDate <= getDate()),
	constraint [ExpDate_Check] check (ExpirationDate > IssueDate and (datediff(year, issueDate , ExpirationDate) >= 3)), 
	constraint [Day_Of_Exp] check (ExpirationDate = eomonth(ExpirationDate)),						
	constraint [Type_FK] foreign key ([Type]) references [CreditCardType] (TypeID),       
	constraint [Status_FK] foreign key ([Status]) references [Status] (StatusID)
)

create table Payment(
	PaymentID int identity(1,1) not null, 
	PaymentDate date not null,
	PaymentAmount decimal (10,2) not null, 
	CreditCardNum varchar(16) not null,
	constraint [PK_Payment] primary key (PaymentID),
	constraint [PaymentAmount_Check] check (PaymentAmount > 0 ),
	constraint [FK_CreditCardNum] foreign key (CreditCardNum) references CreditCard (CreditCardNum) 
)

create table PurchaseTypes(
	TypeId int identity(1,1) not null,
	ValidType varchar(35) not null
	constraint [PK_PurchaseTypes] primary key (TypeId)
	constraint [Type_Check] check (ValidType in ('FOOD', 'LODGING', 'UTILITY', 'TRAVEL', 'CLOTHING', 'RESTAURANT', 'GROCERIES', 'CAR'))
	constraint [PurchaseType_Unique] unique (ValidType)
)

create table Vendors(
	VendorId int not null,
	VendorName varchar(40) not null,
	VendorStreet varchar(40) not null,
	VendorCity varchar(40) not null,
	VendorState varchar(2) not null,
	VendorZip varchar(5) not null,
	constraint [PK_Vendors] primary key (VendorId),
	constraint [Zip_Check] check (len(VendorZip) = 5)
	constraint [Vendor_Unique] unique (VendorName, VendorStreet, VendorCity, VendorState, VendorZip)
)

create table Purchases(
	PurchaseNum int identity(1,1) not null ,
	Amount decimal(10,2) not null,
	Date date not null,
	Vendor int not null,
	PurchaseType int not null,
	CreditCardNum varchar(16) not null,
	Constraint [PK_Purchases] primary key (PurchaseNum),
	Constraint [FK_Types] foreign key (PurchaseType) references PurchaseTypes(TypeId),
	Constraint [FK_Vendors] foreign key (Vendor) references Vendors(VendorId),
	Constraint [FK_CCNum] foreign key (CreditCardNum) references CreditCard(CreditCardNum),
	constraint [Purchase_Check] check (Amount > 0) 
)

create table FeeType(
	FeeTypeID int identity(1,1) not null,
	FeeType varchar(45) not null
	constraint[PK_FEETYPEID] primary key(FeeTypeID),
	constraint [Fee_Check] check (FeeType in ('LATEPAYMENT', 'INTEREST')),
	constraint [FeeType_Unique] unique (FeeType)
)

create table Fees(
	FeeNum int identity(1,1) not null,
	FeeType int not null,
	DateApplied Date not null,
	Amount Decimal(10,2) not null,
	CreditCardNum varchar(16) not null
	constraint [PK_FEENUM] primary key(FeeNum),
	constraint [FK_FEETYPE] foreign key(FeeType) references FeeType(FeeTypeID),
	constraint [FK_CREDNUM] foreign key(CreditCardNum) references CreditCard(CreditCardNum),
	constraint [FeeAmount_Check] check (Amount > 0)
)

create table Refund(
	RefundID int identity(1,1) not null,
	PurchaseNum int not null,
	CreditCardNum varchar(16) not null,
	Amount Decimal(10,2) not null,
	constraint [PK_REFUNDID] primary key(RefundID),
	constraint [FK_PURCHNUM] foreign key(PurchaseNum) references Purchases(PurchaseNum),
	constraint [FK_CREDITNUM] foreign key(CreditCardNum) references CreditCard(CreditCardNum),
	constraint [RefundAmount_Check] check (Amount > 0)
)
