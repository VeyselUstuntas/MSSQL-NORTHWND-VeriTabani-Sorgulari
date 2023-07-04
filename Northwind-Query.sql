--Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
select CompanyName,ContactName,Address , City,Country 
from Customers where Country='Brazil'
order by CompanyName

--— Brezilya’da olmayan müşteriler
select CompanyName,ContactName,Address , City,Country 
from Customers where Country<>'Brazil'
order by CompanyName

--— Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
select CompanyName,Country from Customers where Country in ('Spain','Germany','France') order by CompanyName

--–Faks numarasını bilmediğim müşteriler
select CompanyName,Fax from Customers where Fax is null

--— Londra’da ya da Paris’de bulunan müşterilerim
select * from Customers where City='London' or City='Paris'

--— Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
select CompanyName,ContactName,City,ContactTitle from Customers where City='México D.F.' and ContactTitle='Owner'

--— C ile başlayan ürünlerimin isimleri ve fiyatları
select ProductName,UnitPrice from Products where ProductName like 'c%' order by UnitPrice desc,ProductName

--— Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
select FirstName as Ad, LastName Soyadı , BirthDate [Doğum Tarihleri] from Employees where FirstName like 'A%' 
order by Ad,Soyadı,[Doğum Tarihleri] asc

--— İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
select CompanyName,ContactTitle,City from Customers where CompanyName like '%RESTAURANT%'

--— 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
select ProductID as ID,ProductName as [Ürün Adı], UnitPrice as Fiyatı from Products where UnitPrice between 50 and 100 order by UnitPrice desc

--— 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) 
--ve SiparişTarihi (OrderDate) bilgileri
select OrderID,OrderDate as [Sipariş Tarihi] from Orders
where OrderDate between '1996-07-01' and '1996-12-31' order by [Sipariş Tarihi]

--Müşterilerimi ülkeye göre sıralıyorum:
select DISTINCT Country ,CompanyName,ContactTitle from Customers order by Country 

--Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
select ProductName,UnitPrice from Products order by UnitPrice desc

--Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin 
--sonuç olarak ürün adı ve fiyatını istiyoruz:
select ProductName,UnitPrice,UnitsInStock from Products order by UnitPrice desc,UnitsInStock 

--1 Numaralı kategoride kaç ürün vardır..?
select c.CategoryID as id,c.CategoryName as names,COUNT(p.ProductName) adet from Products as p
join Categories as c on p.CategoryID = c.CategoryID
where c.CategoryID=1
group by c.CategoryName,c.CategoryID

--Kaç farklı ülkeye ihracat yapıyorum..?
select count(distinct ShipCountry) from Orders

--Bu ülkeler hangileri..?
select ShipCountry from Orders
group by ShipCountry
order by ShipCountry asc

--En Pahalı 5 ürün
select top 5 ProductName,UnitPrice from Products order by UnitPrice desc

--ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
select CustomerID,count(*) from Orders where CustomerID='ALFKI'
group by CustomerID

--Ürünlerimin toplam maliyeti
select sum(Quantity*UnitPrice) from [Order Details]

--Ortalama Ürün Fiyatım
select avg(UnitPrice) from Products

--En Pahalı Ürünün Adı
select top 1 ProductName from Products order by UnitPrice desc

select ProductName,UnitPrice from Products where UnitPrice=(select max(UnitPrice) from Products)

--En az kazandıran sipariş
select * from [Order Details]

select top 1 OrderID, sum(UnitPrice*Quantity) [en az kazandıran] from [Order Details]
group by OrderID
order by [en az kazandıran]

--Müşterilerimin içinde en uzun isimli müşteri (harf sayısı)
select top 1 CompanyName,max(len(CompanyName)) uzunluk from Customers group by CompanyName order by uzunluk desc

--Çalışanlarımın Ad, Soyad ve Yaşları
select CONCAT(FirstName,' ',LastName) as [Çalışan Ad Soyad],abs(DATEDIFF(YEAR,GETDATE(),BirthDate)) from Employees

--Hangi üründen toplam kaç adet alınmış..?
select p.ProductID,p.ProductName,sum(od.Quantity) from [Order Details] as od
join Products as p on p.ProductID=od.ProductID
group by p.ProductID,p.ProductName
order by p.ProductID,p.ProductName

--Hangi siparişte toplam ne kadar kazanmışım..?
select OrderID,sum((UnitPrice*Quantity)) from [Order Details]
group by OrderID
order by OrderID

--Hangi kategoride toplam kaç adet ürün bulunuyor..?
select c.CategoryID as category_Id, c.CategoryName as Category_Name, count(p.ProductName) as adet from Products as p
join Categories as c on c.CategoryID=p.CategoryID
group by c.CategoryID,c.CategoryName
order by category_Id

--1000 Adetten fazla satılan ürünler?
select distinct od.ProductID,p.ProductName ,sum(od.Quantity) as [Toplam Satılan Adet] from Products as p
join [Order Details] as od on od.ProductID=p.ProductID
group by od.ProductID,p.ProductName
having sum(od.Quantity)>1000
order by [Toplam Satılan Adet] asc

--Hangi Müşterilerim hiç sipariş vermemiş..? (91 Müşteriden 89’u sipariş vermişti..)
select CustomerID [Müşeri ID],CompanyName [Şirket Adı] from Customers where CustomerID not in (select CustomerID from Orders)

--Hangi ürün hangi kategoride..
select p.ProductName [Ürün Adı], c.CategoryName as [Kategori] from Products as p
join Categories as c on c.CategoryID=p.CategoryID
order by c.CategoryName asc

--Hangi tedarikçi hangi ürünü sağlıyor ? 
	select s.SupplierID [Tedarikçi Id], s.CompanyName [Tedarikçi Firma], p.ProductName as [Tedarikçi Sağladığı Ürün] from Products as p
	join Suppliers as s on s.SupplierID=p.SupplierID
	order By s.SupplierID

--Hangi sipariş hangi kargo şirketi ile ne zaman gönderilmiş..?
select o.OrderID as SiparişNo ,s.CompanyName [Kargo Firması], convert(date,o.ShippedDate) as [Sipariş Tarihi] from orders as o
join Shippers as s on s.ShipperID=o.ShipVia

--Hangi siparişi hangi müşteri verir..?
select o.OrderID Sipariş_ID, c.CompanyName as Müşeteri from Customers as c
join Orders as o on o.CustomerID=c.CustomerID
order by o.OrderID

--Hangi çalışan, toplam kaç sipariş almış..?
select CONCAT(e.FirstName,' ',e.LastName) as [ Çalışan bilgileri], count(o.EmployeeID) [Toplan Alınan Sipariş] from Orders as o
join Employees as e on e.EmployeeID=o.EmployeeID
group by  CONCAT(e.FirstName,' ',e.LastName),e.EmployeeID
order by e.EmployeeID

--En fazla siparişi kim almış..?
select top 1 CONCAT(e.FirstName,' ',e.LastName) as [ Çalışan bilgileri], count(o.EmployeeID) [Toplan Alınan Sipariş] from Orders as o
join Employees as e on e.EmployeeID=o.EmployeeID
group by  CONCAT(e.FirstName,' ',e.LastName),e.EmployeeID
order by [Toplan Alınan Sipariş] desc

--Hangi siparişi, hangi çalışan, hangi müşteri vermiştir..?
select o.OrderID [Sipariş No],CONCAT(e.FirstName,' ',e.LastName) as [ Çalışan bilgileri], c.CompanyName Müşteri  from Orders as o
join Customers as c on c.CustomerID=o.CustomerID
join Employees as e on e.EmployeeID=o.EmployeeID
order by o.OrderID

-- Hangi ürün, hangi kategoride bulunmaktadır..? Bu ürünü kim tedarik etmektedir..?
select p.ProductName as Ürün_Adı, c.CategoryName Ürün_Kategorisi, s.CompanyName Tedarikçi from Products as p
join Categories as c on c.CategoryID=p.CategoryID
join Suppliers as s on s.SupplierID=p.SupplierID
order by p.ProductID

-- Hangi siparişi hangi müşteri vermiş, hangi çalışan almış, hangi tarihte, hangi kargo şirketi tarafından gönderilmiş hangi üründen kaç adet alınmış,
--hangi fiyattan alınmış, ürün hangi kategorideymiş bu ürünü hangi tedarikçi sağlamış

select * from Orders
select * from [Order Details]

select o.OrderID [Sipariş ID],c.CompanyName [Müşteri Bilgisi],concat(e.FirstName,' ',e.LastName) as [Siparişi Alan Çalışan Bilgileri], 
cast(o.ShippedDate as date) [Sipariş Tarihi], s.CompanyName [Kargo Firması],p.ProductName as Ürün_Adı,sum(od.Quantity) Satılan_Adet, od.UnitPrice as Fiyat, cat.CategoryName,
sup.CompanyName Tedarikçi from Orders as o
join Customers as c on c.CustomerID=o.CustomerID
join Employees as e on e.EmployeeID=o.EmployeeID
join Shippers as s on s.ShipperID=o.ShipVia
join [Order Details] as od on od.OrderID=o.OrderID
join Products as p on p.ProductID=od.ProductID
join Suppliers as sup on sup.SupplierID = p.SupplierID
join Categories as cat on cat.CategoryID = p.CategoryID
group by o.OrderID, c.CompanyName, concat(e.FirstName,' ',e.LastName), cast(o.ShippedDate as date),s.CompanyName, p.ProductName, od.UnitPrice, cat.CategoryName,sup.CompanyName
order by [Sipariş ID]


--Altında ürün bulunmayan kategoriler
select CategoryName from Categories where CategoryID not in (select distinct CategoryID from Products)

--Hangi çalışan şimdiye kadar  toplam kaç sipariş almış..?
select CONCAT(FirstName, ' ',LastName) as Çalışan_Ad_Soyad, count(o.EmployeeID) [Aldığı Sipraiş Sayısı] from Employees as e
join Orders as o on o.EmployeeID=e.EmployeeID
group by CONCAT(FirstName, ' ',LastName),e.EmployeeID
order by e.EmployeeID
