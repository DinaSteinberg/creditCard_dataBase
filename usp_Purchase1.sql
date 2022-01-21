use CreditCard
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE usp_Purchase
	@amount decimal(10, 2),
	@date date,
	@vendor int,
	@purchaseType int,
	@creditCard varchar(16)
AS
BEGIN
SET NOCOUNT ON;

	BEGIN TRY

	declare @cardStatus int
	select @cardStatus = [Status]
	from CreditCard
	where CreditCardNum like @creditCard

	declare @statusDesc varchar(20)
	select @statusDesc = [Status]
	from [Status]
	where @cardStatus = StatusID

	if(@statusDesc like 'Cancelled' or @statusDesc like 'Lost')
	begin;
		throw 69998, 'Card is not active', 1
	end

	declare @expiration date
	select @expiration = expirationDate
	from CreditCard
	where CreditCardNum like @creditCard

	if @expiration < getDate()
	begin;
		throw 69999, 'Card is expired', 1
	end

	declare @availableCredit decimal (10,2)
	select @availableCredit =
	AvailableCredit from CreditCard
	where CreditCardNum like @creditCard

	if @availableCredit < @amount
	begin;
		throw 70000, 'Insufficient Funds', 1
	end

	declare @purchaseDescription varchar
	select @purchaseDescription = validType
	from PurchaseTypes
	where TypeID = @purchaseType

	if @purchaseDescription like 'CAR' and @amount > 40000
	begin;
		throw 70001, 'Invalid purchase amount for purchase type CAR', 1
	end

	else if @purchaseDescription like 'TRAVEL' and @amount > 15000
	begin;
		throw 70001, 'Invalid purchase amount for purchase type TRAVEL', 1
	end

	else if @amount > 5000
	begin;
		throw 70001, 'Invalid purchase amount for purchase type', 1
	end

	insert into Purchases(Amount,[Date], Vendor, PurchaseType, CreditCardNum)
	values(@amount, @date, @vendor, @purchaseType, @creditCard)

	update CreditCard
	set CurrentBalance = CurrentBalance + @amount
	where CreditCardNum like @creditCard
	
    
	END TRY
	Begin catch;

		throw 70002, 'Unable to process purchase', 1

	end catch
END
GO
