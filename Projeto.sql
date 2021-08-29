-- Selecionando 
SELECT * FROM sales.transactions;

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

select * from sales.transactions where sales_amount=-1;
 
select distinct(transactions.currency) from transactions;
-- 'INR\r'
-- 'INR'
select count(*) from transactions where transactions.currency='INR\r';

select count(*) from transactions where transactions.currency='INR';

select * from transactions where transactions.currency='USD\r' or transactions.currency='USD';

select sum(transactions.sales_amount) from transactions inner join date on transactions.order_date=date.date
where date.year=2020 and transactions.currency='INR\r' or transactions.currency='USD\r';