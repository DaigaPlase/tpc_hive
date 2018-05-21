USE dev_grp_base;
drop view q2_min_ps_supplycost;
create view q2_min_ps_supplycost as
select
	p.partkey as min_p_partkey,
	min(ps.supplycost) as min_ps_supplycost
from
	tpc_part_dsv p,
	tpc_partsupp_dsv ps,
	tpc_supplier_dsv s,
	tpc_nation_dsv n,
	tpc_region_dsv r
where
	p.partkey = ps.partkey
	and s.suppkey = ps.suppkey
	and s.nationkey = n.nationkey
	and n.regionkey = r.regionkey
	and r.name = 'EUROPE'
group by
	p.partkey;

select
	s.acctbal,
	s.name,
	n.name,
	p.partkey,
	p.mfgr,
	s.address,
	s.phone,
	s.comment
from
	tpc_part_dsv p,
	tpc_supplier_dsv s,
	tpc_partsupp_dsv ps,
	tpc_nation_dsv n,
	tpc_region_dsv r,
	q2_min_ps_supplycost
where
	p.partkey = ps.partkey
	and s.suppkey = ps.suppkey
	and p.size = 37
	and p.type like '%COPPER'
	and s.nationkey = n.nationkey
	and n.regionkey = r.regionkey
	and r.name = 'EUROPE'
	and ps.supplycost = min_ps_supplycost
	and p.partkey = min_p_partkey
order by
	s.acctbal desc,
	n.name,
	s.name,
	p.partkey
limit 100;
