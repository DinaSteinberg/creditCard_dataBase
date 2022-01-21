use CreditCard
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE usp_Fee
	@FeeType int,
	@DateApplied Date,
	@Amount	decimal (8,2),
	@CreditCardNum varchar(20)
AS
BEGIN

	SET NOCOUNT ON;

	begin try

	declare @AvailCredit decimal (8,2) 
	select @AvailCredit = 
	AvailableCredit from CreditCard 
	where CreditCardNum like @CreditCardNum

	if @AvailCredit < @Amount
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
	set CurrentBalance = CurrentBalance + @amount
	where CreditCardNum like @CreditCardNum

	insert into Fees(FeeType, DateApplied, Amount, CreditCardNum)
	values (@FeeType, @DateApplied, @Amount,@CreditCardNum)

	end try
	begin catch;
	
	throw 70002, 'Fee not processed', 1;

	end catch

END
GO
