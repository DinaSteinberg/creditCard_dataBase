use CreditCard
go 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROCEDURE usp_refund
	@PurchaseNum int,
	@CreditCardNum varchar (16),
	@Amount	decimal (8,2)
AS
BEGIN

	SET NOCOUNT ON;
	begin try
	declare @AvailCredit decimal (8,2) 
	select @AvailCredit = 
	availablecredit from CreditCard 
	where CreditCardNum like @CreditCardNum

	if @AvailCredit < @amount
	begin; 
	throw 70000, 'Insufficient Funds', 1
	end

	declare @expDate date
	select @expDate = 
	ExpirationDate from CreditCard
	where CreditCardNum like @CreditCardNum

	if @expDate < GETDATE()
	begin;
		throw 700001, 'Credit Card expired', 1
	end

	declare @statusID int                            
	select @statusID = [Status]
	from CreditCard
	where CreditCardNum like @CreditCardNum

	declare @status varchar(20)
	select @status = [Status]
	from [Status]
	where StatusID = @statusID

	if @status not like 'Active' 
	begin;
		throw 80019, 'Inactive Card', 1
	end

	update CreditCard
	set CurrentBalance = CurrentBalance - @amount
	where CreditCardNum like @CreditCardNum

	insert into Refund ( PurchaseNum, CreditCardNum, Amount)
	values (@PurchaseNum, @CreditCardNum, @amount)

	end try
	begin catch;
	
	throw 70002, 'Refund not processed', 1;

	end catch

END
GO
