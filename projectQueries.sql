use CreditCard
go 

--1. For each CreditCard, list the CreditCard ID, Name of the Company that Issued the Card and the 
--total $ amount of purchases that were made using the CreditCard

select CreditCard.CreditCardNum,Company, isnull(sum(amount),0) as AmountOfPurchases
from CreditCard
left join Purchases on Purchases.CreditCardNum=CreditCard.CreditCardNum
group by CreditCard.CreditCardNum,Company

--2. For each month of the year 2021, list the total $ amount of 
--purchases that were made for Food.  Include all Food Purchases made for all CreditCards.

select year([Date]),
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 1) As January,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 2) As February,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 3) As March,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 4) As April,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 5) As May,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 6) As June,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 7) As July,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 8) As August,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 9) As September,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 10) As October,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 11) As November,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 12) As December
from Purchases
group by year([Date])
having year([Date]) = 2021

--3.
select validType, 
sum(case when month([Date]) = 1  and year([date]) = 2021 then Purchases.amount else 0 END) As [JanPurchases],
  sum (case when month([Date])= 2 and year([date]) = 2021 then Purchases.amount else 0 END) as [FebPurchases],
  sum (case when month([Date])= 3 and year([date]) = 2021 then Purchases.amount else 0 END ) as [MarchPurchases],
  sum (case when month([Date])= 4  and year([date]) = 2021 then Purchases.amount else 0 end) as [AprilPurchases],
  sum (case when month([Date])= 5  and year([date]) = 2021 then Purchases.amount else 0 end) as [MayPurchase],
  sum (case when month([Date])= 6  and year([date]) = 2021 then Purchases.amount else 0 END) As [JunPurchases],
  sum (case when month([Date])= 7  and year([date]) = 2021 then Purchases.amount else 0 END) As [JulyPurchases],
  sum (case when month([Date])= 8  and year([date]) = 2021 then Purchases.amount else 0 END) As [AugPurchases],
  sum (case when month([Date])= 9  and year([date]) = 2021 then Purchases.amount else 0 END) As [SeptPurchases],
  sum (case when month([Date])= 10 and year([date]) = 2021 then Purchases.amount else 0 END) As [OctPurchases],
  sum (case when month([Date])= 11 and year([date]) = 2021  then Purchases.amount else 0 END) As [NovPurchases],
  sum (case when month([Date])= 12 and year([date]) = 2021 then Purchases.amount else 0 END) As [DecPurchases]
  from PurchaseTypes
	left join Purchases
		on PurchaseTypes.TypeID = Purchases.PurchaseType
			group by validType


--4. List the ID and Company that issued the Card for any CreditCard that will be expiring during the 
--current year.

select CreditCardNum, Company
from CreditCard
where year(ExpirationDate)=2022

--5. For each CreditCard list the CreditCard ID and the Company that 
--issued the card and the amount of years that the individual has had this CreditCard. 

select CreditCardNum, Company, DATEDIFF(year, IssueDate, getDate()) As NumYears
from CreditCard

--6. 
select count(distinct purchaseType) as [Number of Purchase Types]
from Purchases

--7. What is the total amount of LateFees that have been incurred?

select sum(Amount) as amountLateFees
from Fees
inner join feeType on feetype.FeeTypeID=fees.FeeType
where Feetype.FeeType like 'LatePayment'

--8. What is the amount of the largest Purchase that was ever charged to any CreditCard?

select max(Amount) As [Biggest Purchase]
from purchases

--9.
select creditcard.creditcardnum,(
	select isnull(sum(amount),0) from purchases
	where month([date])=1  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum)as JanPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=2  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as FebPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=3  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as MarPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=4  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as AprPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=5  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as MayPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=6  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as JunePurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=7  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as JulPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=8  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as AugPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=9  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as SeptPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=10  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as OctPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=11  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as NovPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=12  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as DecPurchases,(
	select isnull(sum(PaymentAmount),0) from payment 
	where month(paymentdate)=1 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as JanPayment,( 
	select isnull(sum(PaymentAmount),0) from Payment
	where month(paymentdate)=2 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as FebPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=3 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as MarPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=4 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as AprPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=5 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as MayPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=6 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as JunePayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=7 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as JulyPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=8 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as AugPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=9 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as SeptPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=10 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as OctPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=11 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as NovPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=12 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as DecPayment,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=1 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as JanFees,(
	select isnull(sum(amount),0) from Fees 
	where month(dateapplied)=2 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as FebFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=3 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as MarFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=4 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as AprilFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=5 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as MayFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=6 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as JuneFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=7 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as JulyFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=8 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as AugFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=9 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as SeptFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=10 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as OctFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=11 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as NovFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=12 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as DecFees
from CreditCard

--10. Given a specific Vendor and Year, list the total $ amount of purchases made from that Vendor 
--during that year. 

Select sum(Amount) as amountVendor
from Purchases
inner join Vendors on Vendors.vendorID=Purchases.Vendor
where vendor=1324 and year(date)=2020

--11. List the name of the Vendor for which the largest total $ amount
--of Purchases have been made during a given year. The year can be any year  (your choice) 

select VendorName, sum(amount) As[Highest vendor total for 2019]
from Vendors
inner join Purchases
on Purchases.Vendor = Vendors.VendorID
group by VendorName
having sum(amount) = 
	(select max(VendorTotal) 
		from (select sum(amount) VendorTotal
		from Purchases
		where year([Date]) = 2019
		group by Vendor) EachVendorTotal)

--12.	
select validType as LowestPurchaseAmountTypeIn2021
from PurchaseTypes
inner join Purchases 
	on PurchaseTypes.TypeId = Purchases.PurchaseType
where year([date]) = 2021 
group by validType,PurchaseType
having sum(amount) = 
(select min(SumAmnt) 
from 
(select sum(amount) as SumAmnt
from Purchases
where year([Date]) = 2021
group by PurchaseType) Amnts)

--13. Which CreditCards have incurred LateFees during a given month / year? List the CreditCard ID 
--and name of the Company that issued the CreditCard.

Select distinct CreditCard.CreditCardNum, Company
from CreditCard
inner join Fees on Fees.CreditCardNum=CreditCard.CreditCardNum
inner join feeType on feetype.FeeTypeID=fees.FeeType
where Feetype.FeeType like 'LatePayment' and year(dateapplied)=2020

--14. List the total amount spent for all types of Purchases for all Credit Cards. 
--Include in the same results the subtotals for each CreditCard for each type of 
--Purchase, the subtotals for each type of Purchase across all CreditCards  
--(you may have to research rollup and cube to write this query).  
--Include CreditCard that weren’t used and all types of Purchases, even if that type of Purchase hasn’t occurred.

select coalesce( CreditCard.CreditCardNum, '-'),
	 coalesce(PurchaseTypes.ValidType, '-'),
	isnull(sum(amount), 0) as totals
from CreditCard
	left join Purchases
	on Purchases.CreditCardNum = CreditCard.CreditCardNum 
	right join PurchaseTypes
	on  PurchaseTypes.typeId = Purchases.PurchaseType 	 
group by cube(CreditCard.CreditCardNum, PurchaseTypes.ValidType)
order by  CreditCard.CreditCardNum, ValidType 


--And separately for CreditCards and for Purchases here:
select CreditCard.CreditCardNum, isnull(sum(amount), 0) as Totals
from CreditCard
left join Purchases
on Purchases.CreditCardNum = CreditCard.CreditCardNum
group by cube(CreditCard.CreditCardNum)

select PurchaseTypes.ValidType, isnull(sum(amount), 0) as Totals
from PurchaseTypes
left join Purchases
on Purchases.PurchaseType = PurchaseTypes.TypeId
group by cube(PurchaseTypes.ValidType)

--15.	
select VendorName, VendorStreet, VendorCity, VendorState, VendorZip, isnull(sum(amount),0) as TotalPurchases
from Vendors
left join Purchases
	on Vendors.VendorId = Purchases.Vendor
	group by VendorName, VendorStreet, VendorCity, VendorState, VendorZip


--16. For each Vendor, list the vendor name and what are the total purchases for each month of the 
--current year. Include the $ amount for each month on the same row as the Vendor name, 
--flattening the data instead of presenting them on different rows.

select *
from Purchases

select VendorName,
   ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 1 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As JanPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 2 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As FebPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 3 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As MarPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 4 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As AprPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 5 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As MayPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 6 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As JunePurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 7 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As JulyPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 8 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As AugPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 9 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As SeptPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 10 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As OctPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 11 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As NovPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 12 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As DecPurchases
from Vendors


--17.	List the name(s) of each Vendor from whom the individual has purchased ALL the same types of Purchases as Vendor “ShopRite”

select distinct AllPurchases.VendorName
from
	(select  VendorName, PurchaseType
	from Purchases
	inner join Vendors
	on Purchases.Vendor = Vendors.VendorId) As AllPurchases
		inner join
		(select PurchaseType
		from Purchases
			inner join Vendors
			on Purchases.Vendor = Vendors.VendorId
		where VendorName = 'Shop Rite') As ShopRitePurchases
		on AllPurchases.PurchaseType = ShopRitePurchases.PurchaseType

--18.
select distinct VendorName 
from (
select VendorID, VendorName
from Vendors
where VendorZip in ('30312', '27401', '10001')) Vendors1
	inner join Purchases	
		on Vendors1.VendorID = Purchases.Vendor


--19. List the category (type of Purchase) of Purchase for which no Purchases were made during a 
--given month/year

select ValidType 
from PurchaseTypes
where TypeID not in(
select PurchaseType
from Purchases
where year([date]) = 2019)


--Query 20.	 For each CreditCard , if the CreditCard hasn’t been used for Purchases in the past 3 months, list INACTIVE, if CreditCard has been used for at least one 
--Purchase in the past 3 months, list ACTIVE, if the CreditCard has been used for more than 10 Purchases in the last 3 months, list VERY ACTIVE, 

select CreditCardNum,
case
	when datediff(month, MostRecentPurchase, getDate()) > 3 then 'INACTIVE'
	when datediff(month, MostRecentPurchase, getDate()) <= 3 and NumPurchases <=10 then 'ACTIVE'
	when datediff(month, MostRecentPurchase, getDate()) <= 3 and NumPurchases > 10 then 'VERY ACTIVE'
end As CardStatus
from 
(select CreditCardNum, max([Date]) As MostRecentPurchase, count(PurchaseNum) As NumPurchases
from Purchases
group by CreditCardNum) As LatestPurchases


--21.
select Purchases.Vendor, MaxDate, Amount
from Purchases
	inner join 
	(select Vendor, max([Date]) as MaxDate
	from purchases 
	group by Vendor) VendorMaxDate 
		on VendorMaxDate.MaxDate = Purchases.[Date]
		and VendorMaxDate.Vendor = Purchases.Vendor


