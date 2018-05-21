USE dev_grp_base;
drop view q21_tmp1_cached;
drop view q21_tmp2_cached;

create view q21_tmp1_cached as
select
	l.orderkey,
	count(distinct l.suppkey) as count_suppkey,
	max(l.suppkey) as max_suppkey
from
	tpc_lineitem_dsv l
where
	l.orderkey is not null
group by
	l.orderkey;

create view q21_tmp2_cached as
select
	l.orderkey,
	count(distinct l.suppkey) count_suppkey,
	max(l.suppkey) as max_suppkey
from
	tpc_lineitem_dsv l
where
	to_date(l.receiptdate) > to_date(l.commitdate)
	and l.orderkey is not null
group by
	l.orderkey;

select
	name,
	count(1) as numwait
from (
	select name from (
		select
			l3.name,
			t2.orderkey,
			l3.suppkey,
			count_suppkey,
			max_suppkey
		from
			q21_tmp2_cached t2 right outer join (
			select
				name,
				orderkey,
				suppkey from (
				select
					l2.name,
					t1.orderkey,
					l2.suppkey,
					count_suppkey,
					max_suppkey
				from
					q21_tmp1_cached t1 join (
						select
							l1.name,
							l1.orderkey,
							l1.suppkey
						from
							tpc_orders_dsv o join (
							select
								s.name,
								l.orderkey,
								l.suppkey
							from
								tpc_nation_dsv n join tpc_supplier_dsv s
							on
								s.nationkey = n.nationkey
								and n.name = 'SAUDI ARABIA'
								join tpc_lineitem_dsv l
							on
								s.suppkey = l.suppkey
							where
								to_date(l.receiptdate) > to_date(l.commitdate)
								and l.orderkey is not null
						) l1 on o.orderkey = l1.orderkey and o.orderstatus = 'F'
					) l2 on l2.orderkey = t1.orderkey
				) a
			where
				(count_suppkey > 1)
				or ((count_suppkey=1)
				and (suppkey <> max_suppkey))
		) l3 on l3.orderkey = t2.orderkey
	) b
	where
		(count_suppkey is null)
		or ((count_suppkey=1)
		and (suppkey = max_suppkey))
) c
group by
	name
order by
	numwait desc,
	name 
limit 100;
