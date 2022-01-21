insert into Vendors(VendorID, VendorName, VendorStreet, VendorCity, VendorState, VendorZip)
values(1324, 'Rosie''s Boutique', '17 Maple Lane', 'Atlanta', 'GA', 30312)

insert into Vendors(VendorID, VendorName, VendorStreet, VendorCity, VendorState, VendorZip)
values(5768, 'Tony Tacos', '917 West 81st Street', 'New York', 'NY', 10001)

insert into Vendors(VendorID, VendorName, VendorStreet, VendorCity, VendorState, VendorZip)
values(9023, 'Wholesale Market', '803 Jersey Grove', 'Edison', 'NJ', 08818)

insert into Vendors(VendorID, VendorName, VendorStreet, VendorCity, VendorState, VendorZip)
values(2641, 'Con-Ed', '1423 Shore Drive', 'Greensboro', 'NC', 27401)

insert into Vendors(VendorID, VendorName, VendorStreet, VendorCity, VendorState, VendorZip)
values(6721, 'Air BnB', '888 Brannan Street', 'San Frincisco', 'CA', 94103)

insert into Vendors(VendorID, VendorName, VendorStreet, VendorCity, VendorState, VendorZip)
values(9223, 'Plaza Auto Mall', '1786 Coney Island Avenue', 'Brooklyn', 'NY', 11230)



insert into PurchaseTypes(ValidType)
values('FOOD')
insert into PurchaseTypes(ValidType)
values('LODGING')
insert into PurchaseTypes(ValidType)
values('UTILITY')
insert into PurchaseTypes(ValidType)
values('TRAVEL')
insert into PurchaseTypes(ValidType)
values('CLOTHING')
insert into PurchaseTypes(ValidType)
values('RESTAURANT')
insert into PurchaseTypes(ValidType)
values('CAR')
insert into PurchaseTypes(ValidType)
values('GROCERIES')

select *
from PurchaseTypes

exec usp_Purchase 1500.34, '2020-05-22', 1324, 5, 5424678911225577   
exec usp_Purchase 350.00, '2019-12-05', 2641,3,342467891122558
exec usp_Purchase 259.00, '2020-01-14', 9023, 8, 342467891122551
exec usp_Purchase 12000.99, '2021-04-15', 9223, 7, 6424678911225512
exec usp_Purchase 67.93, '2019-12-30', 5768, 6, 5424678911225577

--new insertions
select *
from CreditCard

exec usp_Purchase 2000, '2020-07-18', 9023, 1, 342467891122551

insert into Vendors(VendorID, VendorName, VendorStreet, VendorCity, VendorState, VendorZip)
values(7253, 'Shop Rite', '1080 McDonald Avenue', 'Brooklyn', 'NY', 11230)

exec usp_Purchase 4000, '2020-12-30', 7253, 1, 342467891122551

exec usp_Purchase 2500.13, '2021-05-16', 7253, 1, 342467891122558
exec usp_Purchase 1500.13, '2021-10-16', 7253, 1, 342467891122558

