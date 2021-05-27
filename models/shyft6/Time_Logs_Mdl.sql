{{ config(
    materialized="view",
    schema="shyft6"
)}}


select
    -- count(1)
    c.Job_Start_Date,
    a.*
from (
    select
        -- b.Job_Name Job_Name_Name,
        if(b.Job_Name  LIKE '%Regular%', 'RT',
            if(b.Job_Name  LIKE '%OT%', 'OT',
                if(b.Job_Name  LIKE '%DT%', 'DT',NULL)
                )
            ) Job_Type,
        a.*
    from `gentle-charmer-297601.dbt_wchen_shyft6.Time_Logs` a
    left join `gentle-charmer-297601.dbt_wchen_shyft6.Jobs` b
        on a.Job_Name = b.ID
    ) a
left join {{ref('linkJobStartDateOfTheJob')}} c
    on a.User_Name =c.User_Name and a.Project =c.Project and a.Date =c.Date and a.Job_Type =c.Job_Type