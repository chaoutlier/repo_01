{{ config(
    materialized="view",
    schema="shyft6"
)}}

-- SELECT
--     "RT" Job_Type,
--     a.User_Name,
--     a.Project,
--     a.Date,
--     max(b.Job_Start_Date) Job_Start_Date
-- FROM `gentle-charmer-297601.dbt_wchen_shyft6.Time_Logs` a
-- left join {{ref('rateTable01')}} b
--     on a.User_Name=b.User and a.Project= b.Project and a.Date>= b.Job_Start_Date
-- where b.Job_Name  LIKE '%Regular%'
-- group by 1,2,3,4
-- union all
--     SELECT
--         "OT" Job_Type,
--         a.User_Name,
--         a.Project,
--         a.Date,
--         max(b.Job_Start_Date) Job_Start_Date
--     FROM `gentle-charmer-297601.dbt_wchen_shyft6.Time_Logs` a
--     left join {{ref('rateTable01')}} b
--         on a.User_Name=b.User and a.Project= b.Project and a.Date>= b.Job_Start_Date
--     where b.Job_Name  LIKE '%OT%'
--     group by 1,2,3,4
-- union all
--     SELECT
--         "DT" Job_Type,
--         a.User_Name,
--         a.Project,
--         a.Date,
--         max(b.Job_Start_Date) Job_Start_Date
--     FROM `gentle-charmer-297601.dbt_wchen_shyft6.Time_Logs` a
--     left join {{ref('rateTable01')}} b
--         on a.User_Name=b.User and a.Project= b.Project and a.Date>= b.Job_Start_Date
--     where b.Job_Name  LIKE '%DT%'
--     group by 1,2,3,4


----------------------------------------------------------------------------------------------------------------
-- SELECT
--     a.User_Name,
--     a.Project,
--     a.Date,

--     sum(a.Hours) sum_Hours,

--     max(b.Job_Start_Date) Job_Start_Date_RT,
--     max(c.Job_Start_Date) Job_Start_Date_OT,
--     max(d.Job_Start_Date) Job_Start_Date_DT,

--     max(b.RPH_fromJobs) RPH_fromJobs_RT,
--     max(c.RPH_fromJobs) RPH_fromJobs_OT,
--     max(d.RPH_fromJobs) RPH_fromJobs_DT,

--     max(b.RPH_fromAssignees) RPH_fromAssignees_RT,
--     max(c.RPH_fromAssignees) RPH_fromAssignees_OT,
--     max(d.RPH_fromAssignees) RPH_fromAssignees_DT,

-- FROM `gentle-charmer-297601.dbt_wchen_shyft6.Time_Logs` a
-- left join {{ref('rateTable01')}} b
--     on a.User_Name=b.User and a.Project= b.Project and a.Date>= b.Job_Start_Date
-- left join {{ref('rateTable01')}} c
--     on a.User_Name=c.User and a.Project= c.Project and a.Date>= c.Job_Start_Date
-- left join {{ref('rateTable01')}} d
--     on a.User_Name=d.User and a.Project= d.Project and a.Date>= d.Job_Start_Date

-- where
--         b.Job_Name  LIKE '%Regular%'
--     and c.Job_Name  LIKE '%OT%'
--     and d.Job_Name  LIKE '%DT%'
-- group by 1,2,3


----------------------------------------------------------------------------------------------------------------
SELECT
    a.User_Name,
    e.EmployeeID,
    a.Project,
    a.Date,
    max(b.Job_Start_Date) Job_Start_Date_RT,
    max(c.Job_Start_Date) Job_Start_Date_OT,
    max(d.Job_Start_Date) Job_Start_Date_DT,

    max(f.Date_of_Employment) Date_of_Employment

FROM `gentle-charmer-297601.dbt_wchen_shyft6.Time_Logs` a
left join {{ref('rateTable01')}} b
    on a.User_Name=b.User and a.Project= b.Project and a.Date>= b.Job_Start_Date
left join {{ref('rateTable01')}} c
    on a.User_Name=c.User and a.Project= c.Project and a.Date>= c.Job_Start_Date
left join {{ref('rateTable01')}} d
    on a.User_Name=d.User and a.Project= d.Project and a.Date>= d.Job_Start_Date
left join `gentle-charmer-297601.dbt_wchen_shyft6.Employee` e
    on a.User_Name=e.ID
left join `gentle-charmer-297601.dbt_wchen_shyft6.Dep_Org` f
    on e.EmployeeID =cast(f.Employee_ID as string) and a.Date>=f.Date_of_Employment


where
        b.Job_Name  LIKE '%Regular%'
    and c.Job_Name  LIKE '%OT%'
    and d.Job_Name  LIKE '%DT%'
group by 1,2,3,4