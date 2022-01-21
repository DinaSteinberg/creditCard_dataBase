use CreditCard
go

insert into CreditCardType ([Type])
values ('Visa'), ('MASTERCARD'), ('AMEX'), ('DISCOVER')

insert into [Status] ([Status])
values ('Active'), ('Cancelled'), ('Lost')

exec usp_addCard '5424678911225577', 1, 'CHASE' , '2015-06-08', '2022-07-31', 200.00, 1, 1500.00
exec usp_addCard '5424678911225574', 2 , 'BOA', '2018-08-12', '2022-02-28', 1000.28,  1, 1200.00
exec usp_addCard '6424678911225512', 4 , 'Capital One', '2019-02-16', '2023-01-31', 0.0,  2, 5000.00
exec usp_addCard '342467891122551', 3 , 'Capital One', '2019-02-16', '2023-01-31', 5000.0,  1, 20000.00
exec usp_addCard '342467891122558', 3 , 'Capital One', '2019-02-16', '2023-01-31', 15000.0,  1, 30000.00

exec usp_addPayment '2021-12-29', 8000, '342467891122558'
exec usp_addPayment '2020-08-10',800, '5424678911225577' 
exec usp_addPayment '2020-09-11', 5000, '342467891122551'
exec usp_addPayment '2019-05-05', 4122.75, '342467891122551'
exec usp_addPayment '2021-11-11', 22, '5424678911225574'
exec usp_addPayment '2021-11-11', 10, '5424678911225574'
exec usp_addPayment '2020-09-11', 30, '342467891122551'
