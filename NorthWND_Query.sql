--Brazil�de bulunan m��terilerin �irket Ad�, TemsilciAdi, Adres, �ehir, �lke bilgileri
select CompanyName,ContactName,Address , City,Country 
from Customers where Country='Brazil'
order by CompanyName

--� Brezilya�da olmayan m��teriler
select CompanyName,ContactName,Address , City,Country 
from Customers where Country<>'Brazil'
order by CompanyName

--� �lkesi (Country) YA Spain, Ya France, Ya da Germany olan m��teriler
select CompanyName,Country from Customers where Country in ('Spain','Germany','France') order by CompanyName

--�Faks numaras�n� bilmedi�im m��teriler
select CompanyName,Fax from Customers where Fax is null

--� Londra�da ya da Paris�de bulunan m��terilerim
select * from Customers where City='London' or City='Paris'

--� Hem Mexico D.F�da ikamet eden HEM DE ContactTitle bilgisi �owner� olan m��teriler
select CompanyName,ContactName,City,ContactTitle from Customers where City='M�xico D.F.' and ContactTitle='Owner'

--� C ile ba�layan �r�nlerimin isimleri ve fiyatlar�
select ProductName,UnitPrice from Products where ProductName like 'c%' order by UnitPrice desc,ProductName

--� Ad� (FirstName) �A� harfiyle ba�layan �al��anlar�n (Employees); Ad, Soyad ve Do�um Tarihleri
select FirstName as Ad, LastName Soyad� , BirthDate [Do�um Tarihleri] from Employees where FirstName like 'A%' 
order by Ad,Soyad�,[Do�um Tarihleri] asc

--� �sminde �RESTAURANT� ge�en m��terilerimin �irket adlar�
select CompanyName,ContactTitle,City from Customers where CompanyName like '%RESTAURANT%'

--� 50$ ile 100$ aras�nda bulunan t�m �r�nlerin adlar� ve fiyatlar�
select ProductID as ID,ProductName as [�r�n Ad�], UnitPrice as Fiyat� from Products where UnitPrice between 50 and 100 order by UnitPrice desc

--� 1 temmuz 1996 ile 31 Aral�k 1996 tarihleri aras�ndaki sipari�lerin (Orders), Sipari�ID (OrderID) 
--ve Sipari�Tarihi (OrderDate) bilgileri
select OrderID,OrderDate as [Sipari� Tarihi] from Orders
where OrderDate between '1996-07-01' and '1996-12-31' order by [Sipari� Tarihi]

--M��terilerimi �lkeye g�re s�ral�yorum:
select DISTINCT Country ,CompanyName,ContactTitle from Customers order by Country 

--�r�nlerimi en pahal�dan en ucuza do�ru s�ralama, sonu� olarak �r�n ad� ve fiyat�n� istiyoruz
select ProductName,UnitPrice from Products order by UnitPrice desc

--�r�nlerimi en pahal�dan en ucuza do�ru s�ralas�n, ama stoklar�n� k���kten-b�y��e do�ru g�stersin 
--sonu� olarak �r�n ad� ve fiyat�n� istiyoruz:
select ProductName,UnitPrice,UnitsInStock from Products order by UnitPrice desc,UnitsInStock 

--1 Numaral� kategoride ka� �r�n vard�r..?
select c.CategoryID as id,c.CategoryName as names,COUNT(p.ProductName) adet from Products as p
join Categories as c on p.CategoryID = c.CategoryID
where c.CategoryID=1
group by c.CategoryName,c.CategoryID

--Ka� farkl� �lkeye ihracat yap�yorum..?
select count(distinct ShipCountry) from Orders

--Bu �lkeler hangileri..?
select ShipCountry from Orders
group by ShipCountry
order by ShipCountry asc

--En Pahal� 5 �r�n
select top 5 ProductName,UnitPrice from Products order by UnitPrice desc

--ALFKI CustomerID�sine sahip m��terimin sipari� say�s�..?
select CustomerID,count(*) from Orders where CustomerID='ALFKI'
group by CustomerID

--�r�nlerimin toplam maliyeti
select sum(Quantity*UnitPrice) from [Order Details]

--Ortalama �r�n Fiyat�m
select avg(UnitPrice) from Products

--En Pahal� �r�n�n Ad�
select top 1 ProductName from Products order by UnitPrice desc

select ProductName,UnitPrice from Products where UnitPrice=(select max(UnitPrice) from Products)

--En az kazand�ran sipari�
select * from [Order Details]

select top 1 OrderID, sum(UnitPrice*Quantity) [en az kazand�ran] from [Order Details]
group by OrderID
order by [en az kazand�ran]

--M��terilerimin i�inde en uzun isimli m��teri (harf say�s�)
select top 1 CompanyName,max(len(CompanyName)) uzunluk from Customers group by CompanyName order by uzunluk desc

--�al��anlar�m�n Ad, Soyad ve Ya�lar�
select CONCAT(FirstName,' ',LastName) as [�al��an Ad Soyad],abs(DATEDIFF(YEAR,GETDATE(),BirthDate)) from Employees

--Hangi �r�nden toplam ka� adet al�nm��..?
select p.ProductID,p.ProductName,sum(od.Quantity) from [Order Details] as od
join Products as p on p.ProductID=od.ProductID
group by p.ProductID,p.ProductName
order by p.ProductID,p.ProductName

--Hangi sipari�te toplam ne kadar kazanm���m..?
select OrderID,sum((UnitPrice*Quantity)) from [Order Details]
group by OrderID
order by OrderID

--Hangi kategoride toplam ka� adet �r�n bulunuyor..?
select c.CategoryID as category_Id, c.CategoryName as Category_Name, count(p.ProductName) as adet from Products as p
join Categories as c on c.CategoryID=p.CategoryID
group by c.CategoryID,c.CategoryName
order by category_Id

--1000 Adetten fazla sat�lan �r�nler?
select distinct od.ProductID,p.ProductName ,sum(od.Quantity) as [Toplam Sat�lan Adet] from Products as p
join [Order Details] as od on od.ProductID=p.ProductID
group by od.ProductID,p.ProductName
having sum(od.Quantity)>1000
order by [Toplam Sat�lan Adet] asc

--Hangi M��terilerim hi� sipari� vermemi�..? (91 M��teriden 89�u sipari� vermi�ti..)
select CustomerID [M��eri ID],CompanyName [�irket Ad�] from Customers where CustomerID not in (select CustomerID from Orders)

--Hangi �r�n hangi kategoride..
select p.ProductName [�r�n Ad�], c.CategoryName as [Kategori] from Products as p
join Categories as c on c.CategoryID=p.CategoryID
order by c.CategoryName asc

--Hangi tedarik�i hangi �r�n� sa�l�yor ? 
	select s.SupplierID [Tedarik�i Id], s.CompanyName [Tedarik�i Firma], p.ProductName as [Tedarik�i Sa�lad��� �r�n] from Products as p
	join Suppliers as s on s.SupplierID=p.SupplierID
	order By s.SupplierID

--Hangi sipari� hangi kargo �irketi ile ne zaman g�nderilmi�..?
select o.OrderID as Sipari�No ,s.CompanyName [Kargo Firmas�], convert(date,o.ShippedDate) as [Sipari� Tarihi] from orders as o
join Shippers as s on s.ShipperID=o.ShipVia

--Hangi sipari�i hangi m��teri verir..?
select o.OrderID Sipari�_ID, c.CompanyName as M��eteri from Customers as c
join Orders as o on o.CustomerID=c.CustomerID
order by o.OrderID

--Hangi �al��an, toplam ka� sipari� alm��..?
select CONCAT(e.FirstName,' ',e.LastName) as [ �al��an bilgileri], count(o.EmployeeID) [Toplan Al�nan Sipari�] from Orders as o
join Employees as e on e.EmployeeID=o.EmployeeID
group by  CONCAT(e.FirstName,' ',e.LastName),e.EmployeeID
order by e.EmployeeID

--En fazla sipari�i kim alm��..?
select top 1 CONCAT(e.FirstName,' ',e.LastName) as [ �al��an bilgileri], count(o.EmployeeID) [Toplan Al�nan Sipari�] from Orders as o
join Employees as e on e.EmployeeID=o.EmployeeID
group by  CONCAT(e.FirstName,' ',e.LastName),e.EmployeeID
order by [Toplan Al�nan Sipari�] desc

--Hangi sipari�i, hangi �al��an, hangi m��teri vermi�tir..?
select o.OrderID [Sipari� No],CONCAT(e.FirstName,' ',e.LastName) as [ �al��an bilgileri], c.CompanyName M��teri  from Orders as o
join Customers as c on c.CustomerID=o.CustomerID
join Employees as e on e.EmployeeID=o.EmployeeID
order by o.OrderID

-- Hangi �r�n, hangi kategoride bulunmaktad�r..? Bu �r�n� kim tedarik etmektedir..?
select p.ProductName as �r�n_Ad�, c.CategoryName �r�n_Kategorisi, s.CompanyName Tedarik�i from Products as p
join Categories as c on c.CategoryID=p.CategoryID
join Suppliers as s on s.SupplierID=p.SupplierID
order by p.ProductID

-- Hangi sipari�i hangi m��teri vermi�, hangi �al��an alm��, hangi tarihte, hangi kargo �irketi taraf�ndan g�nderilmi� hangi �r�nden ka� adet al�nm��,
--hangi fiyattan al�nm��, �r�n hangi kategorideymi� bu �r�n� hangi tedarik�i sa�lam��

select * from Orders
select * from [Order Details]

select o.OrderID [Sipari� ID],c.CompanyName [M��teri Bilgisi],concat(e.FirstName,' ',e.LastName) as [Sipari�i Alan �al��an Bilgileri], 
cast(o.ShippedDate as date) [Sipari� Tarihi], s.CompanyName [Kargo Firmas�],p.ProductName as �r�n_Ad�,sum(od.Quantity) Sat�lan_Adet, od.UnitPrice as Fiyat, cat.CategoryName,
sup.CompanyName Tedarik�i from Orders as o
join Customers as c on c.CustomerID=o.CustomerID
join Employees as e on e.EmployeeID=o.EmployeeID
join Shippers as s on s.ShipperID=o.ShipVia
join [Order Details] as od on od.OrderID=o.OrderID
join Products as p on p.ProductID=od.ProductID
join Suppliers as sup on sup.SupplierID = p.SupplierID
join Categories as cat on cat.CategoryID = p.CategoryID
group by o.OrderID, c.CompanyName, concat(e.FirstName,' ',e.LastName), cast(o.ShippedDate as date),s.CompanyName, p.ProductName, od.UnitPrice, cat.CategoryName,sup.CompanyName
order by [Sipari� ID]


--Alt�nda �r�n bulunmayan kategoriler
select CategoryName from Categories where CategoryID not in (select distinct CategoryID from Products)

--Hangi �al��an �imdiye kadar  toplam ka� sipari� alm��..?
select CONCAT(FirstName, ' ',LastName) as �al��an_Ad_Soyad, count(o.EmployeeID) [Ald��� Siprai� Say�s�] from Employees as e
join Orders as o on o.EmployeeID=e.EmployeeID
group by CONCAT(FirstName, ' ',LastName),e.EmployeeID
order by e.EmployeeID
