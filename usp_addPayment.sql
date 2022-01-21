use CreditCard
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE usp_addPayment
	@paymentDate date,
	@amount decimal (10,2),
	@cardNum varchar(16)
AS
BEGIN
	SET NOCOUNT ON;

	begin try


    declare @currBalance decimal (10,2)
	select @currBalance =  CurrentBalance
	from CreditCard 
	where CreditCardNum like @cardNum

	if @amount > @currBalance
	begin; 
		throw 90002, 'Amount above balance', 1
	end


	declare @statusID int                            
	select @statusID = [Status]
	from CreditCard
	where CreditCardNum like @cardNum 

	declare @status varchar(20)
	select @status = [Status]
	from [Status]
	where StatusID = @statusID

	if @status not like 'Active' 
	begin;
		throw 80009, 'Inactive Card Error', 1
	end

	insert into Payment(PaymentDate, PaymentAmount, CreditCardNum)
	values (@paymentDate, @amount, @cardNum)

	update CreditCard
	set CurrentBalance = CurrentBalance - @amount
	where CreditCardNum like @cardNum

	end try
	begin catch;

	throw 80009, 'Payment Could not be Processed', 1
	end catch 
END
GO

