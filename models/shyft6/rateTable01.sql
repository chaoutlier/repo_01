SELECT
    a.User User,
    b.Project Project,
    c.Project_Name Project_Name,
    b.Job_Name Job_Name,
    b.Start_Date Job_Start_Date,
    max(a.Rate_Per_Hour) RPH_fromAssignees,
    max(b.Rate_Per_Hour) RPH_fromJobs
    -- max(if(b.Job_Name  LIKE '%Regular%', a.Rate_Per_Hour, 0)) PayRate_RT,
    -- max(if(b.Job_Name  LIKE '%OT%', a.Rate_Per_Hour, 0)) PayRate_OT,
    -- max(if(b.Job_Name  LIKE '%DT%', a.Rate_Per_Hour, 0)) PayRate_DT,
    -- max(if(b.Job_Name  LIKE '%Regular%', b.Rate_Per_Hour, 0)) BillRate_RT,
    -- max(if(b.Job_Name  LIKE '%OT%', b.Rate_Per_Hour, 0)) BillRate_OT,
    -- max(if(b.Job_Name  LIKE '%DT%', b.Rate_Per_Hour, 0)) BillRate_DT
FROM  `gentle-charmer-297601.dbt_wchen_shyft6.Assignees` a
LEFT JOIN `gentle-charmer-297601.dbt_wchen_shyft6.Jobs` b  ON a.Job_Name  = b.ID
LEFT JOIN `gentle-charmer-297601.dbt_wchen_shyft6.Projects` c ON b.Project  = c.ID
-- where
        -- b.Job_Name  LIKE '%Regular%'
    --     a.User =569700000000416001
    -- and b.Project=569700000002550009
group by 1,2,3,4,5
ORDER BY User DESC