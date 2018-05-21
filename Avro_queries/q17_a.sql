USE dev_grp_base;
drop view q17_lineitem_tmp_cached;

create view q17_lineitem_tmp_cached as
select
	l.partkey as t_partkey,
	0.2 * avg(l.quantity) as t_avg_quantity
from
	tpc_lineitem_avro l
group by l.partkey;

select
	sum(a.extendedprice) / 7.0 as avg_yearly
from (
	select
		l2.quantity,
		l2.extendedprice,
		l1.t_avg_quantity
	from
		q17_lineitem_tmp_cached l1 join
		(select
			l2.quantity,
			p.partkey,
			l2.extendedprice
		from
			tpc_part_avro p,
			tpc_lineitem_avro l2
		where
			p.partkey = l2.partkey
			and p.brand = 'Brand#23'
			and p.container = 'MED BOX'
		) l2 on l2.partkey = l1.t_partkey
) a 
where quantity < t_avg_quantity;
