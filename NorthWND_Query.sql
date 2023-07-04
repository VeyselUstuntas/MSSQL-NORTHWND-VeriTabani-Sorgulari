--Brazil’de bulunan müþterilerin Þirket Adý, TemsilciAdi, Adres, Þehir, Ülke bilgileri
select CompanyName,ContactName,Address , City,Country 
from Customers where Country='Brazil'
order by CompanyName

--— Brezilya’da olmayan müþteriler
select CompanyName,ContactName,Address , City,Country 
from Customers where Country<>'Brazil'
order by CompanyName

--— Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müþteriler
select CompanyName,Country from Customers where Country in ('Spain','Germany','France') order by CompanyName

--–Faks numarasýný bilmediðim müþteriler
select CompanyName,Fax from Customers where Fax is null

--— Londra’da ya da Paris’de bulunan müþterilerim
select * from Customers where City='London' or City='Paris'

--— Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müþteriler
select CompanyName,ContactName,City,ContactTitle from Customers where City='México D.F.' and ContactTitle='Owner'

--— C ile baþlayan ürünlerimin isimleri ve fiyatlarý
select ProductName,UnitPrice from Products where ProductName like 'c%' order by UnitPrice desc,ProductName

--— Adý (FirstName) ‘A’ harfiyle baþlayan çalýþanlarýn (Employees); Ad, Soyad ve Doðum Tarihleri
select FirstName as Ad, LastName Soyadý , BirthDate [Doðum Tarihleri] from Employees where FirstName like 'A%' 
order by Ad,Soyadý,[Doðum Tarihleri] asc

--— Ýsminde ‘RESTAURANT’ geçen müþterilerimin þirket adlarý
select CompanyName,ContactTitle,City from Customers where CompanyName like '%RESTAURANT%'

--— 50$ ile 100$ arasýnda bulunan tüm ürünlerin adlarý ve fiyatlarý
select ProductID as ID,ProductName as [Ürün Adý], UnitPrice as Fiyatý from Products where UnitPrice between 50 and 100 order by UnitPrice desc

--— 1 temmuz 1996 ile 31 Aralýk 1996 tarihleri arasýndaki sipariþlerin (Orders), SipariþID (OrderID) 
--ve SipariþTarihi (OrderDate) bilgileri
select OrderID,OrderDate as [Sipariþ Tarihi] from Orders
where OrderDate between '1996-07-01' and '1996-12-31' order by [Sipariþ Tarihi]

--Müþterilerimi ülkeye göre sýralýyorum:
select DISTINCT Country ,CompanyName,ContactTitle from Customers order by Country 

--Ürünlerimi en pahalýdan en ucuza doðru sýralama, sonuç olarak ürün adý ve fiyatýný istiyoruz
select ProductName,UnitPrice from Products order by UnitPrice desc

--Ürünlerimi en pahalýdan en ucuza doðru sýralasýn, ama stoklarýný küçükten-büyüðe doðru göstersin 
--sonuç olarak ürün adý ve fiyatýný istiyoruz:
select ProductName,UnitPrice,UnitsInStock from Products order by UnitPrice desc,UnitsInStock 

--1 Numaralý kategoride kaç ürün vardýr..?
select c.CategoryID as id,c.CategoryName as names,COUNT(p.ProductName) adet from Products as p
join Categories as c on p.CategoryID = c.CategoryID
where c.CategoryID=1
group by c.CategoryName,c.CategoryID

--Kaç farklý ülkeye ihracat yapýyorum..?
select count(distinct ShipCountry) from Orders

--Bu ülkeler hangileri..?
select ShipCountry from Orders
group by ShipCountry
order by ShipCountry asc

--En Pahalý 5 ürün
select top 5 ProductName,UnitPrice from Products order by UnitPrice desc

--ALFKI CustomerID’sine sahip müþterimin sipariþ sayýsý..?
select CustomerID,count(*) from Orders where CustomerID='ALFKI'
group by CustomerID

--Ürünlerimin toplam maliyeti
select sum(Quantity*UnitPrice) from [Order Details]

--Ortalama Ürün Fiyatým
select avg(UnitPrice) from Products

--En Pahalý Ürünün Adý
select top 1 ProductName from Products order by UnitPrice desc

select ProductName,UnitPrice from Products where UnitPrice=(select max(UnitPrice) from Products)

--En az kazandýran sipariþ
select * from [Order Details]

select top 1 OrderID, sum(UnitPrice*Quantity) [en az kazandýran] from [Order Details]
group by OrderID
order by [en az kazandýran]

--Müþterilerimin içinde en uzun isimli müþteri (harf sayýsý)
select top 1 CompanyName,max(len(CompanyName)) uzunluk from Customers group by CompanyName order by uzunluk desc

--Çalýþanlarýmýn Ad, Soyad ve Yaþlarý
select CONCAT(FirstName,' ',LastName) as [Çalýþan Ad Soyad],abs(DATEDIFF(YEAR,GETDATE(),BirthDate)) from Employees

--Hangi üründen toplam kaç adet alýnmýþ..?
select p.ProductID,p.ProductName,sum(od.Quantity) from [Order Details] as od
join Products as p on p.ProductID=od.ProductID
group by p.ProductID,p.ProductName
order by p.ProductID,p.ProductName

--Hangi sipariþte toplam ne kadar kazanmýþým..?
select OrderID,sum((UnitPrice*Quantity)) from [Order Details]
group by OrderID
order by OrderID

--Hangi kategoride toplam kaç adet ürün bulunuyor..?
select c.CategoryID as category_Id, c.CategoryName as Category_Name, count(p.ProductName) as adet from Products as p
join Categories as c on c.CategoryID=p.CategoryID
group by c.CategoryID,c.CategoryName
order by category_Id

--1000 Adetten fazla satýlan ürünler?
select distinct od.ProductID,p.ProductName ,sum(od.Quantity) as [Toplam Satýlan Adet] from Products as p
join [Order Details] as od on od.ProductID=p.ProductID
group by od.ProductID,p.ProductName
having sum(od.Quantity)>1000
order by [Toplam Satýlan Adet] asc

--Hangi Müþterilerim hiç sipariþ vermemiþ..? (91 Müþteriden 89’u sipariþ vermiþti..)
select CustomerID [Müþeri ID],CompanyName [Þirket Adý] from Customers where CustomerID not in (select CustomerID from Orders)

--Hangi ürün hangi kategoride..
select p.ProductName [Ürün Adý], c.CategoryName as [Kategori] from Products as p
join Categories as c on c.CategoryID=p.CategoryID
order by c.CategoryName asc

--Hangi tedarikçi hangi ürünü saðlýyor ? 
	select s.SupplierID [Tedarikçi Id], s.CompanyName [Tedarikçi Firma], p.ProductName as [Tedarikçi Saðladýðý Ürün] from Products as p
	join Suppliers as s on s.SupplierID=p.SupplierID
	order By s.SupplierID

--Hangi sipariþ hangi kargo þirketi ile ne zaman gönderilmiþ..?
select o.OrderID as SipariþNo ,s.CompanyName [Kargo Firmasý], convert(date,o.ShippedDate) as [Sipariþ Tarihi] from orders as o
join Shippers as s on s.ShipperID=o.ShipVia

--Hangi sipariþi hangi müþteri verir..?
select o.OrderID Sipariþ_ID, c.CompanyName as Müþeteri from Customers as c
join Orders as o on o.CustomerID=c.CustomerID
order by o.OrderID

--Hangi çalýþan, toplam kaç sipariþ almýþ..?
select CONCAT(e.FirstName,' ',e.LastName) as [ Çalýþan bilgileri], count(o.EmployeeID) [Toplan Alýnan Sipariþ] from Orders as o
join Employees as e on e.EmployeeID=o.EmployeeID
group by  CONCAT(e.FirstName,' ',e.LastName),e.EmployeeID
order by e.EmployeeID

--En fazla sipariþi kim almýþ..?
select top 1 CONCAT(e.FirstName,' ',e.LastName) as [ Çalýþan bilgileri], count(o.EmployeeID) [Toplan Alýnan Sipariþ] from Orders as o
join Employees as e on e.EmployeeID=o.EmployeeID
group by  CONCAT(e.FirstName,' ',e.LastName),e.EmployeeID
order by [Toplan Alýnan Sipariþ] desc

--Hangi sipariþi, hangi çalýþan, hangi müþteri vermiþtir..?
select o.OrderID [Sipariþ No],CONCAT(e.FirstName,' ',e.LastName) as [ Çalýþan bilgileri], c.CompanyName Müþteri  from Orders as o
join Customers as c on c.CustomerID=o.CustomerID
join Employees as e on e.EmployeeID=o.EmployeeID
order by o.OrderID

-- Hangi ürün, hangi kategoride bulunmaktadýr..? Bu ürünü kim tedarik etmektedir..?
select p.ProductName as Ürün_Adý, c.CategoryName Ürün_Kategorisi, s.CompanyName Tedarikçi from Products as p
join Categories as c on c.CategoryID=p.CategoryID
join Suppliers as s on s.SupplierID=p.SupplierID
order by p.ProductID

-- Hangi sipariþi hangi müþteri vermiþ, hangi çalýþan almýþ, hangi tarihte, hangi kargo þirketi tarafýndan gönderilmiþ hangi üründen kaç adet alýnmýþ,
--hangi fiyattan alýnmýþ, ürün hangi kategorideymiþ bu ürünü hangi tedarikçi saðlamýþ

select * from Orders
select * from [Order Details]

select o.OrderID [Sipariþ ID],c.CompanyName [Müþteri Bilgisi],concat(e.FirstName,' ',e.LastName) as [Sipariþi Alan Çalýþan Bilgileri], 
cast(o.ShippedDate as date) [Sipariþ Tarihi], s.CompanyName [Kargo Firmasý],p.ProductName as Ürün_Adý,sum(od.Quantity) Satýlan_Adet, od.UnitPrice as Fiyat, cat.CategoryName,
sup.CompanyName Tedarikçi from Orders as o
join Customers as c on c.CustomerID=o.CustomerID
join Employees as e on e.EmployeeID=o.EmployeeID
join Shippers as s on s.ShipperID=o.ShipVia
join [Order Details] as od on od.OrderID=o.OrderID
join Products as p on p.ProductID=od.ProductID
join Suppliers as sup on sup.SupplierID = p.SupplierID
join Categories as cat on cat.CategoryID = p.CategoryID
group by o.OrderID, c.CompanyName, concat(e.FirstName,' ',e.LastName), cast(o.ShippedDate as date),s.CompanyName, p.ProductName, od.UnitPrice, cat.CategoryName,sup.CompanyName
order by [Sipariþ ID]


--Altýnda ürün bulunmayan kategoriler
select CategoryName from Categories where CategoryID not in (select distinct CategoryID from Products)

--Hangi çalýþan þimdiye kadar  toplam kaç sipariþ almýþ..?
select CONCAT(FirstName, ' ',LastName) as Çalýþan_Ad_Soyad, count(o.EmployeeID) [Aldýðý Sipraiþ Sayýsý] from Employees as e
join Orders as o on o.EmployeeID=e.EmployeeID
group by CONCAT(FirstName, ' ',LastName),e.EmployeeID
order by e.EmployeeID
