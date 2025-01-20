# Write your MySQL query statement below
with category_accounts as (
    select 
        account_id,
        income,
        case 
            when income < 20000 then 'Low Salary'
            when income between 20000 and 50000 then 'Average Salary'
            when income > 50000 then 'High Salary' 
        end as category
    from Accounts
),
category as (
    select 'Low Salary' as category
    union all
    select 'Average Salary'
    union all
    select 'High Salary'

)

select c.category, count(ca.category) as accounts_count
from category c left join category_accounts ca
on c.category = ca.category
group by c.category;

