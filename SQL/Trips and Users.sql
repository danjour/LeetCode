with taxistas_n_banidos as (
    select users_id,banned from Users where banned = 'No' and role ='driver'
)
select request_at as "Day", round((a/b),2) as "Cancellation Rate" from (
select 
distinct 
T.request_at,
SUM(CASE WHEN T.status in ('cancelled_by_driver','cancelled_by_client') THEN 1.0 ELSE 0.0 END) AS a,
count(*) as b
from Trips T
left join Users U on T.client_id = U.users_id
left join taxistas_n_banidos TNB on TNB.users_id = T.driver_id
where U.banned='No' and TNB.banned = 'No'
group by 1
)
where request_at BETWEEN '2013-10-01' AND '2013-10-03'