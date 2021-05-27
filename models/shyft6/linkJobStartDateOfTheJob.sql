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

SELECT
    -- "RT" Job_Type,
    a.User_Name,
    a.Project,
    a.Date,
    max(b.Job_Start_Date) Job_Start_Date
FROM `gentle-charmer-297601.dbt_wchen_shyft6.Time_Logs` a
left join {{ref('rateTable01')}} b
    on a.User_Name=b.User and a.Project= b.Project and a.Date>= b.Job_Start_Date
left join {{ref('rateTable01')}} c
    on a.User_Name=c.User and a.Project= c.Project and a.Date>= c.Job_Start_Date
left join {{ref('rateTable01')}} d
    on a.User_Name=d.User and a.Project= d.Project and a.Date>= d.Job_Start_Date
where
        b.Job_Name  LIKE '%Regular%'
    and c.Job_Name  LIKE '%OT%'
    and d.Job_Name  LIKE '%DT%'
group by 1,2,3