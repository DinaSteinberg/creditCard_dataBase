exec usp_Fee 1,'2019-12-29', 100.54, 342467891122558
exec usp_Fee 1,'2020-11-29', 100.33, 5424678911225577
exec usp_Fee 2,'2018-09-18', 1900.00, 342467891122551
exec usp_Fee 2,'2017-12-29', 1299.00, 342467891122551
exec usp_Fee 2,'2020-11-11', 80.00, 5424678911225574


select *
from fees

--put in info for Refund Fees Fee Type
insert into FeeType(FeeType)
values('LatePayment'),('Interest')
