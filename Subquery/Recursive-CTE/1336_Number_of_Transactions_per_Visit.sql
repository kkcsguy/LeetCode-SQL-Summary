# Write your MySQL query statement below
#这道题也不是特别特别复杂，只是需要把知识点都补充好了，逻辑上不是很难
#注意：第一个CTE非recursive也讲"recursive"写在第一个CTE
with recursive a as (
#2. 统计每个转账次数 的user数量
select transactions_count,count(user_id) as visits_count
    from(
        #1. 统计每个user每个visit date的转账次数
        select v.user_id,visit_date,count(t.amount) as transactions_count
        #注意：需要统计来了0次的，因此改为left join
        from visits v left join transactions t 
        on v.user_id = t.user_id 
        and v.visit_date = t.transaction_date
        group by v.user_id,visit_date) temp
    group by transactions_count
),
#注意：用recursive获得连续数列的方法
#3. 用recursive构建0->最大转账次数的连续数列
b(n) as (
    select 0  
    union all 
    select n+1 from b 
    where n<(select max(transactions_count) from a)
)
#4.降统计结果merge到连续数列上
select b.n as transactions_count,
        ifnull(visits_count,0) as visits_count
from a right join b 
on a.transactions_count = b.n

