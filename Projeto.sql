-- Selecionando 
select * from sales.transactions;
 
select count(*) from sales.transactions;

select count(*) from sales.customrs;

-- Filtrando
select * from sales.transactions where market_code="Mark001";

select count(*) from sales.transactions where market_code="Mark001";

select count(*) from sales.transactions where currency="USD";

-- Inner Join

select sales.transactions.*, sales.date.* 
from sales.transactions 
inner join sales.date
on sales.transactions.order_date=sales.date.date 
where sales.date.year=2020;

-- Soma do total de vendas no ano de 2020
select sum(sales.transactions.sales_amount) 
from sales.transactions 
inner join sales.date
on sales.transactions.order_date=sales.date.date 
where sales.date.year=2020;

-- Filtro and 
select sum(sales.transactions.sales_amount) 
from sales.transactions 
inner join sales.date
on sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.transactions.market_code="Mark001";

-- Filtro distinct
select distinct product_code from sales.transactions where market_code='Mark001';

