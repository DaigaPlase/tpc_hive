USE tpc_dbase;
select
	c_count,
	count(*) as custdist
from
	(
		select
			c.custkey as c_custkey,
			count(o.orderkey) as c_count
		from
			tpc_customer_parq c left outer join tpc_orders_parq o on
				c.custkey = o.custkey
				and not o.comment like '%special%requests%'
		group by
			c.custkey
	) c_orders
group by
	c_count
order by
	custdist desc,
	c_count desc;

