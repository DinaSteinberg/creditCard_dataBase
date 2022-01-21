use CreditCard
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE usp_addCard
	@cardNum varchar(16), 
	@cardType int,
	@company varchar(45),
	@issueDate date,
	@expirationDate date,
	@currentBalance decimal (10,2),
	@cardStatus int,
	@creditLimit decimal(10,2)
AS
BEGIN
	begin try
	SET NOCOUNT ON;
	
	declare @typeName varchar(20)
	select @typeName = [Type] 
	from CreditCardType
	where TypeID = @cardType
	if (len(@cardNum) != 16 and @typeName in ('VISA' , 'MASTERCARD', 'DISCOVER')) or (len(@cardNum) != 15 and @typeName like 'AMEX')
	begin; 
	throw 80000, 'Invalid Card Number', 1
	end


	insert into CreditCard(CreditCardNum, [Type], Company, IssueDate, ExpirationDate, CurrentBalance,[Status], CreditLimit)
	values(@cardNum, @cardType, @company, @issueDate, @expirationDate, @currentBalance, @cardStatus, @creditLimit)
	end try
	begin catch;
	throw 80001, 'Card could not be processed', 1;
	end catch

END
GO