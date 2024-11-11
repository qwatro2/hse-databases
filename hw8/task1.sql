-- point A
create procedure NEW_JOB(
    job_id varchar(10), 
    job_title varchar(35), 
    min_salary integer
)
language sql
as $$
insert into jobs values (job_id, job_title, min_salary, 2 * min_salary);
$$;

-- point B
call NEW_JOB('SY_ANAL', 'System Analyst', 6000);
