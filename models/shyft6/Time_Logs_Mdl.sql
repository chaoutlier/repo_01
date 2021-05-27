{{ config(
    materialized="view",
    schema="shyft6"
)}}


-- select
--     -- count(1)
--     -- c.Job_Start_Date,
--     a.*
-- from (
--     select
--         -- b.Job_Name Job_Name_Name,
--         if(b.Job_Name  LIKE '%Regular%', 'RT',
--             if(b.Job_Name  LIKE '%OT%', 'OT',
--                 if(b.Job_Name  LIKE '%DT%', 'DT',NULL)
--                 )
--             ) Job_Type,
--         a.*
--     from `gentle-charmer-297601.dbt_wchen_shyft6.Time_Logs` a
--     left join `gentle-charmer-297601.dbt_wchen_shyft6.Jobs` b
--         on a.Job_Name = b.ID
--     ) a
-- -- left join {{ref('linkJobStartDateOfTheJob')}} c
-- --     on a.User_Name =c.User_Name and a.Project =c.Project and a.Date =c.Date and a.Job_Type =c.Job_Type



select
    f.Business_Development BD,
    f.Account_Manager AM,
    f.Recruiter RC,
    -- b.Job_Start_Date_RT,
    -- b.Job_Start_Date_OT,
    -- b.Job_Start_Date_DT,
    -- b.Date_of_Employment,
    c.RPH_fromAssignees RPH_fromAssignees_RT,
    c.RPH_fromJobs RPH_fromJobs_RT,
    d.RPH_fromAssignees RPH_fromAssignees_OT,
    d.RPH_fromJobs RPH_fromJobs_OT,
    e.RPH_fromAssignees RPH_fromAssignees_DT,
    e.RPH_fromJobs RPH_fromJobs_DT,
    a.*
from (
    select
        User_Name,
        Project,
        Date,
        sum(Hours) sum_Hours
    from `gentle-charmer-297601.dbt_wchen_shyft6.Time_Logs`
    group by 1,2,3
    ) a
left join {{ref('linkJobStartDateOfTheJob')}} b
    on a.User_Name =b.User_Name and a.Project =b.Project and a.Date =b.Date
left join {{ref('rateTable01')}} c
    on a.User_Name =c.User and a.Project =c.Project and b.Job_Start_Date_RT =c.Job_Start_Date
left join {{ref('rateTable01')}} d
    on a.User_Name =d.User and a.Project =d.Project and b.Job_Start_Date_OT =d.Job_Start_Date
left join {{ref('rateTable01')}} e
    on a.User_Name =e.User and a.Project =e.Project and b.Job_Start_Date_DT =e.Job_Start_Date

left join `gentle-charmer-297601.dbt_wchen_shyft6.Dep_Org` f
    on b.EmployeeID =cast(f.Employee_ID as string) and b.Date_of_Employment =f.Date_of_Employment

where
        c.Job_Name  LIKE '%Regular%'
    and d.Job_Name  LIKE '%OT%'
    and e.Job_Name  LIKE '%DT%'



