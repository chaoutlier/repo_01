{{ config(
    materialized="view",
    schema="shyft6"
)}}

select
    b.EmployeeID,
    concat(b.First_Name,' ',b.Last_Name) EmployeeName,
    a.*,
    c.Non_Billable_Expense__
from (
    select
        User_Name,
        Project,
        DATE_ADD(date_trunc(Date, WEEK),INTERVAL 6 DAY) Date_trncWk,

        max(BD) BD,
        max(AM) AM,
        max(RC) RC,

        sum(sum_Hours) sum_Hours,
        avg(RPH_fromAssignees_RT) RPH_fromAssignees_RT,
        avg(RPH_fromJobs_RT) RPH_fromJobs_RT,
        avg(RPH_fromAssignees_OT) RPH_fromAssignees_OT,
        avg(RPH_fromJobs_OT) RPH_fromJobs_OT,
        avg(RPH_fromAssignees_DT) RPH_fromAssignees_DT,
        avg(RPH_fromJobs_DT) RPH_fromJobs_DT
    from {{ref('Time_Logs_Mdl')}}
    group by 1,2,3
    ) a
left join `gentle-charmer-297601.dbt_wchen_shyft6.Employee` b
    on a.User_Name=b.ID

left join `gentle-charmer-297601.dbt_wchen_shyft6.Non-Billable_Expense_Amount` c
    -- on a.Date_trncWk=c.Week and cast(b.EmployeeID as string)=c.ID
    on a.Date_trncWk=c.Week and b.EmployeeID=cast(c.ID as string)


