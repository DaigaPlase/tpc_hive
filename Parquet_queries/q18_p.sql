USE tpc_dbase;
drop view q18_tmp_cached;
drop table q18_large_volume_customer_cached;

create view q18_tmp_cached as
select
	l.orderkey,
	sum(l.quantity) as t_sum_quantity
from
	tpc_lineitem_parq l
where
	l.orderkey is not null
group by
	l.orderkey;

create table q18_large_volume_customer_cached as
select
	c.name,
	c.custkey,
	o.orderkey,
	o.orderdate,
	o.totalprice,
	sum(l.quantity)
from
	tpc_customer_parq c,
	tpc_orders_parq o,
	q18_tmp_cached t,
	tpc_lineitem_parq l
where
	c.custkey = o.custkey
	and o.orderkey = t.orderkey
	and o.orderkey is not null
	and t.t_sum_quantity > 300
	and o.orderkey = l.orderkey
	and l.orderkey is not null
group by
	c.name,
	c.custkey,
	o.orderkey,
	o.orderdate,
	o.totalprice
order by
	o.totalprice desc,
	o.orderdate 
limit 100;
