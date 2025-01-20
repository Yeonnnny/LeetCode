# Write your MySQL query statement below
with confirm as (
    select user_id, count(action) as confirmed_cnt
    from Confirmations 
    where action = 'confirmed'
    group by user_id
),
total as(
    select user_id, count(action) as total_cnt
    from Confirmations
    group by user_id
),
confirm_rate as (
    select t.user_id as user_id, round(confirmed_cnt/total_cnt, 2) as confirm_rate
    from total t join confirm c
    on t.user_id = c.user_id
)

select s.user_id, ifnull(c.confirm_rate, 0.00) as confirmation_rate
from Signups s left join confirm_rate c
on s.user_id = c.user_id;
