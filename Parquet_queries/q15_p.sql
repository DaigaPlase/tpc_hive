USE tpc_dbase;
drop view revenues;
drop view maxrevenue;
create view revenues as
	select
		l.suppkey as supplier_no,
		sum(l.extendedprice * (1 - l.discount)) as total_revenue
	from
		tpc_lineitem_parq l
	where
		to_date(l.shipdate) >= '1996-01-01' 
		and to_date(l.shipdate) < '1996-04-01'
	group by
		l.suppkey;

create view maxrevenue as
	select
		max(total_revenue) as maxrev
	from
		revenues;

select
	s.suppkey,
	s.name,
	s.address,
	s.phone,
	total_revenue
from
	tpc_supplier_parq s,
	revenues,
	maxrevenue
where
	s.suppkey = supplier_no
	and total_revenue = maxrev
order by
	s.suppkey;

drop view revenues;
drop view maxrevenue;